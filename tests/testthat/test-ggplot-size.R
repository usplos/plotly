context("size")

test_that("size is a vector if it is specified", {
  pplot <- ggplot(palmerpenguins::penguins) +
    geom_point(aes(bill_length_mm, bill_depth_mm, size=flipper_length_mm))
  L <- expect_doppelganger_built(pplot, "size-is-a-vector")
  m <- L$data[[1]]$marker
  expect_that(m, is_a("list"))
  expect_true(length(m$size) > 1)
  expect_identical(L$data[[1]]$showlegend, FALSE)
})

countrypop <- data.frame(
  country = c("Paraguay", "Peru", "Philippines"),
  population = c(7, 31, 101),
  edu = c(4.2, 1.75, 1.33),
  illn = c(0.38, 1.67, 0.43)
)

gg <- ggplot(countrypop, aes(edu, illn, colour = country, size = population)) +
  geom_point()

test_that("global scaling works for sizes over different traces", {
  L <- expect_doppelganger_built(gg, "size-global-scaling")
  expect_equivalent(length(L$data), 3)  # 1 trace per country (3)
  expect_true(as.numeric(L$data[[1]]$marker$size) <
                as.numeric(L$data[[2]]$marker$size))
  expect_true(as.numeric(L$data[[2]]$marker$size) <
                as.numeric(L$data[[3]]$marker$size))
})
