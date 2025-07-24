test_that("lerp looks good", {
  expect_equal(
    lerp("red", "yellow", .5) |>
      colorfast::int_to_col(),
    "#FF661EFF" # orange
  )
  expect_equal(
    lerp("red", "blue", .5) |>
      colorfast::int_to_col(),
    "#710169FF" # purple
  )
  expect_equal(
    lerp("red", "blue", .3) |>
      colorfast::int_to_col(),
    "#A20838FF" # more redish
  )
  expect_equal(
    lerp("red", "blue", .7) |>
      colorfast::int_to_col(),
    "#4500A0FF" # more bluish
  )
  expect_equal(
    lerp("#FF0000FF", "#FFFFFFFF", .5) |>
      colorfast::int_to_col(),
    "#FF6A7DFF"
  )
  expect_equal(
    lerp("#FF0000FF", "#FFFFFF88", .5) |>
      colorfast::int_to_col(),
    "#FF6A7DFF"
  )
  expect_equal(
    lerp("#FF000066", "#FFFFFF88", .5) |>
      colorfast::int_to_col(),
    "#FF6A7DEE"
  )
})
