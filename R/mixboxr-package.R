#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @useDynLib mixboxr, .registration = TRUE
## usethis namespace: end
NULL

.onUnload <- function(libpath) {
  library.dynam.unload("mixboxr", libpath)
}
