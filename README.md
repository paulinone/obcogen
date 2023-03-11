
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

Now you could type out hr1 \<- data.frame(Sepal.Length = c(5.1, 4.9,
4.7, 4.6, 5.0, 5.4), Sepal.Width = c(3.5, 3.0, 3.2, 3.1, 3.6, 3.9),
Petal.Length = c(1.4, 1.4, 1.3, 1.5, 1.4. 1.7), Petal.Width = c(0.2,
0.2, 0.2 0.2, 0.2, 0.4), Species = c(“setosa”, “setosa”, “setosa”,
“setosa”, “setosa”, “setosa”)). But what if you forget to type a ‘c’ or
a ‘,’ or forgot an ‘s’ in ‘setosa’. (All of these may or may have happen
while writting out this short example). Your object would not be the
same. Then the code would break and frankly I would rather not waste
time doing this.

``` r
library(obcogen)
gen_code(hr)
#> [1] "data.frame(Sepal.Length = as.numeric(c(5.1, 4.9, 4.7, 4.6, 5, 5.4)), Sepal.Width = as.numeric(c(3.5, 3, 3.2, 3.1, 3.6, 3.9)), Petal.Length = as.numeric(c(1.4, 1.4, 1.3, 1.5, 1.4, 1.7)), Petal.Width = as.numeric(c(0.2, 0.2, 0.2, 0.2, 0.2, 0.4)), Species = factor(c('setosa', 'setosa', 'setosa', 'setosa', 'setosa', 'setosa'), levels = c('setosa', 'versicolor', 'virginica')))"
```

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

.
