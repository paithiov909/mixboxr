# mixboxr


<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

mixboxr is an R package for mixing two colors using the
[Mixbox](https://scrtwpns.com/mixbox/) algorithm. It is a wrapper around
their C/C++ implementation.

## Usage

``` r
pkgload::load_all(export_all = FALSE)
#> ℹ Loading mixboxr

library(colorfast)

blue <- col_to_int("blue")
yellow <- col_to_int("yellow")

# mix 50% blue and 50% yellow, resulting in green in the Mixbox color space
mixed <- mixboxr::lerp(blue, yellow, 0.5)
mixed
#> [1] -10185138

# for comparison, here we interpolate the same colors with `scales::colour_ramp()`.
# this is done in the CIELAB color space.
ramped <- scales::colour_ramp(c("blue", "yellow"))(0.5)

grid::grid.newpage()
grid::grid.circle(x = 0.25, y = 0.5, r = 0.3, gp = grid::gpar(col = int_to_col(mixed), fill = int_to_col(mixed)))
grid::grid.circle(x = 0.75, y = 0.5, r = 0.3, gp = grid::gpar(col = ramped, fill = ramped))
```

<img src="man/figures/README-basic-usage-1.png" style="width:100.0%" />

``` r
library(ggplot2)

cap <- ragg::agg_capture()

rasts <-
  data.frame(
    x = runif(1000),
    y = runif(1000),
    col = sample(c("red", "yellow", "blue"), 1000, replace = TRUE)
  ) |>
  dplyr::group_by(col) |>
  dplyr::group_map(~ {
    gp <- ggplot(.) +
      geom_point(aes(x = x, y = y, colour = .y$col), size = 12) +
      scale_color_identity() +
      scale_size_identity()
    print(gp)
    cap(native = TRUE)
  })

dev.off()
#> agg_png 
#>       2

result <- purrr::reduce(rasts, ~ mixboxr::lerp(.x, .y, 0.5))
grid::grid.newpage()
grid::grid.raster(result, interpolate = TRUE)
```

<img src="man/figures/README-ggplot2-1.png" style="width:100.0%" />

## License

This package is licensed under the [Creative Commons
Attribution-NonCommercial 4.0 International
License](https://creativecommons.org/licenses/by-nc/4.0/).
