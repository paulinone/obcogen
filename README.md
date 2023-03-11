
<!-- README.md is generated from README.Rmd. Please edit that file -->

# obcogen

<!-- badges: start -->
<!-- badges: end -->

The goal of obcogen is to …

## Installation

You can install the development version of obcogen from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("paulinone/obcogen")
```

## Example

Imagine you want to test that first six rows of the iris dataset equal
the following.

``` r
hr <- head(iris)
hr
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#> 1          5.1         3.5          1.4         0.2  setosa
#> 2          4.9         3.0          1.4         0.2  setosa
#> 3          4.7         3.2          1.3         0.2  setosa
#> 4          4.6         3.1          1.5         0.2  setosa
#> 5          5.0         3.6          1.4         0.2  setosa
#> 6          5.4         3.9          1.7         0.4  setosa
```

Now you could type out
`hr1 <- data.frame(Sepal.Length = c(5.1, 4.9, 4.7, 4.6, 5.0, 5.4), Sepal.Width = c(3.5, 3.0, 3.2, 3.1, 3.6, 3.9), Petal.Length = c(1.4, 1.4, 1.3, 1.5, 1.4, 1.7), Petal.Width = c(0.2, 0.2, 0.2, 0.2, 0.2, 0.4), Species = c("setosa", "setosa", "setosa", "setosa", "setosa", "setosa"))`.
But what if you forget to type a `c` or a `,` or forgot an `'s'` in
`'setosa`. (All of these may or may have happen while writing out this
short example). Your object would not be the same. Then the code would
break and frankly I would rather not waste time doing this. This example
is 6 rows, but what if you were doing the whole `iris` dataset.

``` r
library(obcogen)
code_gen(hr)
#> [1] "data.frame(Sepal.Length = as.numeric(c(5.1, 4.9, 4.7, 4.6, 5, 5.4)), Sepal.Width = as.numeric(c(3.5, 3, 3.2, 3.1, 3.6, 3.9)), Petal.Length = as.numeric(c(1.4, 1.4, 1.3, 1.5, 1.4, 1.7)), Petal.Width = as.numeric(c(0.2, 0.2, 0.2, 0.2, 0.2, 0.4)), Species = factor(c('setosa', 'setosa', 'setosa', 'setosa', 'setosa', 'setosa'), levels = c('setosa', 'versicolor', 'virginica')))"
```

``` r
## The code I wrote above
hr1 <- data.frame(Sepal.Length = c(5.1, 4.9, 4.7, 4.6, 5.0, 5.4), Sepal.Width = c(3.5, 3.0, 3.2, 3.1, 3.6, 3.9), Petal.Length = c(1.4, 1.4, 1.3, 1.5, 1.4, 1.7), Petal.Width = c(0.2, 0.2, 0.2, 0.2, 0.2, 0.4), Species = c("setosa", "setosa", "setosa", "setosa", "setosa", "setosa"))

## The code generated that was copy and pasted
hr2 <- data.frame(Sepal.Length = as.numeric(c(5.1, 4.9, 4.7, 4.6, 5, 5.4)), Sepal.Width = as.numeric(c(3.5, 3, 3.2, 3.1, 3.6, 3.9)), Petal.Length = as.numeric(c(1.4, 1.4, 1.3, 1.5, 1.4, 1.7)), Petal.Width = as.numeric(c(0.2, 0.2, 0.2, 0.2, 0.2, 0.4)), Species = factor(c('setosa', 'setosa', 'setosa', 'setosa', 'setosa', 'setosa'), levels = c('setosa', 'versicolor', 'virginica')))

waldo::compare(hr, hr1)
#> `old$Species` is an S3 object of class <factor>, an integer vector
#> `new$Species` is a character vector ('setosa', 'setosa', 'setosa', 'setosa', 'setosa', ...)
waldo::compare(hr, hr2)
#> ✔ No differences
```

I failed to realize that species was a factor and hr and hr1 were not
the same, but hr and hr are the same.

And just a final comparison, with both waldo and testthat

``` r
## this should not work
try(testthat::expect_equal(head(iris), hr1))
#> Error : head(iris) not equal to `hr1`.
#> Component "Species": 'current' is not a factor

waldo::compare(head(iris), hr2)
#> ✔ No differences
testthat::expect_equal(head(iris), hr2)
```

It works! They are infact identical. .
