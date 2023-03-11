
# obcogen

<!-- badges: start -->
<!-- badges: end -->

The goal of obcogen (object code generator) was to create an ability to create code that would build a data.frames or tibbles. The idea came about when creating tests and I was expecting an equal tibble, but I did not want to type out 20 observations for 5 variables. Imagine if it was bigger...

## Installation

You can install the development version of obcogen from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("paulinone/obcogen")
```

## Example

Imagine you have the top 6 rows of the iris dataset

``` r
hr <- head(iris)
hr
```
 Now you could type out hr1 <- data.frame(Sepal.Length = c(5.1, 4.9, 4.7, 4.6, 5.0, 5.4), Sepal.Width = c(3.5, 3.0, 3.2, 3.1, 3.6, 3.9), Petal.Length = c(1.4, 1.4, 1.3, 1.5, 1.4. 1.7), Petal.Width = c(0.2, 0.2, 0.2 0.2, 0.2, 0.4), Species = c("setosa", "setosa", "setosa", "setosa", "setosa", "setosa")). But what if you forget to type a 'c' or a ',' or forgot a 's' in 'setosa'. All things I did while writing out this example. Then the code would break and frankly I would rather not waste time doing this. 
 
``` r
library(obcogen)
gen_code(hr)
```

