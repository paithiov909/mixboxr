#' Mixbox interpolation between two colors
#'
#' @description
#' Blends two colors using the 'mixbox' algorithm.
#' The input is expected to be an integer vector with the color
#' channels packed in the following way:
#'   - red: bits 0-7
#'   - green: bits 8-15
#'   - blue: bits 16-23
#'   - alpha: bits 24-31
#'
#' You can use [colorfast::col_to_int()] to convert colors to integers
#' and [colorfast::int_to_col()] to convert back integers to hexdecimal colors.
#'
#' @param x,y Colors to interpolate between
#' @param t Mixing ratio
#' @returns Interpolated color
#' @export
lerp <- function(x, y, t) {
  if (t < 0 || t > 1) {
    rlang::warn("`t` must be between 0 and 1")
  }
  UseMethod("lerp")
}

#' @export
lerp.default <- function(x, y, t) {
  lerp_cpp(x, y, t)
}

#' @export
lerp.nativeRaster <- function(x, y, t) {
  out <- lerp_cpp(as.integer(x), as.integer(y), t)
  dim(out) <- dim(x)
  class(out) <- c("nativeRaster", class(x))
  out
}
