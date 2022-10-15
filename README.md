
<!-- README.md is generated from README.Rmd. Please edit that file -->

# chrv

<!-- badges: start -->
<!-- badges: end -->

**English version of README is not available for now**

`{chrv}`はよく使うちょっとした計算をするための関数のパッケージ。参考文献は各関数のドキュメントに記載している。

## Installation

You can install the development version of `{chrv}` like so:

``` r
devtools::install_github("indenkun/chrv")
```

## Example

``` r
library(chrv)
set.seed(123)
df <- data.frame(sex = sample(c("M", "F"), 10, replace = TRUE),
                 age = round(rnorm(10, 40, 10)),
                 height = round(rnorm(10, 165, 5), 1),
                 weight = round(rnorm(10, 60, 5), 1),
                 Cr = round(rnorm(10, 1, 0.3), 2),
                 `Cys-C` = round(rnorm(10, 1, 0.1), 2),
                 SUNa = round(rnorm(10, 1, 0.2), 2),
                 SUCr = round(rnorm(10, 1, 0.2), 2),
                 check.names = TRUE)
```

### `BMI_cal()`

身長と体重の値からBMIを計算する。値をそのまま入力またはベクトルで入力しても、データを指定し、列名または列番号で指定しても計算できる。

デフォルトでは、身長がm単位で計算されるが、cm単位にも指定で変更できる。

``` r
BMI_cal(height = df$height, weight = df$weight, h.unit = "cm")
#>  [1] 17.1 22.9 25.2 19.1 25.1 24.3 21.8 25.2 24.7 24.5
BMI_cal(height = "height", weight = "weight", data = df, h.unit = "cm")
#>  [1] 17.1 22.9 25.2 19.1 25.1 24.3 21.8 25.2 24.7 24.5
BMI_cal(height = 3, weight = 4, data = df, h.unit = "cm")
#>  [1] 17.1 22.9 25.2 19.1 25.1 24.3 21.8 25.2 24.7 24.5
```

### `weight_cal()`

身長とBMIから体重を計算する。

``` r
weight_cal(height = df$height, BMI = 22, h.unit = "cm")
#>  [1] 66.5 61.7 53.0 62.5 58.2 56.1 59.1 56.2 57.3 57.7
weight_cal(height = "height", BMI = 22, data = df, h.unit = "cm")
#>  [1] 66.5 61.7 53.0 62.5 58.2 56.1 59.1 56.2 57.3 57.7
```

### `eGFR_cal()`

血清クレアチニン値か血清シスタチンC値と年齢、性別からeGFR（日本人）を計算する。

性別は指定できる。

``` r
eGFR_cal(value = df$Cr, age = df$age, sex = df$sex, male = "M", female = "F")
#>  [1] 49.4 54.8 77.0 58.3 78.8 59.7 51.8 81.6 38.6 50.4
eGFR_cal(value = "Cr", age = "age", sex = "sex", data = df, male = "M", female = "F")
#>  [1] 49.4 54.8 77.0 58.3 78.8 59.7 51.8 81.6 38.6 50.4
eGFR_cal(value = df$Cys.C, age = df$age, sex = df$sex, male = "M", female = "F", v.type = "Cys-C")
#>  [1] 26.7 46.2 63.4 73.2 58.4 50.1 54.5 54.5 68.9 59.4
eGFR_cal(value = "Cys.C", age = "age", sex = "sex", data = df, male = "M", female = "F", v.type = "Cys-C")
#>  [1] 26.7 46.2 63.4 73.2 58.4 50.1 54.5 54.5 68.9 59.4
```

### `UCrV_24h_cal()`

年齢、体重、身長から田中の式を用いて推定24時間尿中クレアチニン排泄量を計算する。

``` r
UCrV_24h_cal(age = df$age, weight = df$weight, height = df$height, h.unit = "cm")
#>  [1] 1214.340 1323.138 1110.710 1216.347 1293.681 1151.697 1182.201 1206.981
#>  [9] 1235.822 1253.705
UCrV_24h_cal(age = "age", weight = "weight", height = "height", data = df, h.unit = "cm")
#>  [1] 1214.340 1323.138 1110.710 1216.347 1293.681 1151.697 1182.201 1206.981
#>  [9] 1235.822 1253.705
```

### `UNaV_24h_cal()`

随時尿クレアチニン排泄量、随時尿ナトリウム排泄量、年齢、体重、身長から田中の式を用いて推定24時間尿中ナトリウム排泄量を計算する。

``` r
UNaV_24h_cal(SUNa = df$SUNa, SUCr = df$SUCr, age = df$age, weight = df$weight, height = df$height, h.unit = "cm")
#>  [1] 156.2554 124.6966 145.0450 136.3213 131.2342 151.7439 174.3763 130.2149
#>  [9] 141.1765 141.2754
UNaV_24h_cal(SUNa = "SUNa", SUCr = "SUCr", age = "age", weight = "weight", height = "height", data = df, h.unit = "cm")
#>  [1] 156.2554 124.6966 145.0450 136.3213 131.2342 151.7439 174.3763 130.2149
#>  [9] 141.1765 141.2754
```

### `salt_24h_cal()`

随時尿クレアチニン排泄量、随時尿ナトリウム排泄量、年齢、体重、身長から田中の式を用いて推定24時間尿中ナトリウム排泄量を計算し、そこから推定24時間塩分摂取量を計算する。

``` r
salt_24h_cal(SUNa = df$SUNa, SUCr = df$SUCr, age = df$age, weight = df$weight, height = df$height, h.unit = "cm")
#>  [1]  9.191493  7.335093  8.532056  8.018900  7.719661  8.926113 10.257428
#>  [8]  7.659697  8.304498  8.310321
salt_24h_cal(SUNa = "SUNa", SUCr = "SUCr", age = "age", weight = "weight", height = "height", data = df, h.unit = "cm")
#>  [1]  9.191493  7.335093  8.532056  8.018900  7.719661  8.926113 10.257428
#>  [8]  7.659697  8.304498  8.310321
```

### `KtV_cal()`

Daugirdasの式を用いてvariable-volume single-pool (VVSP) Kt/Vを計算する。

``` r
set.seed(123)
df <- data.frame(pre.BUN = round(rnorm(10, 70, 3), 1),
                 post.BUN = round(rnorm(10, 30, 3), 1),
                 time = sample(3:5, 10, replace = TRUE),
                 post.weight = round(rnorm(10, 60, 10), 1),
                 volume = round(rnorm(10, 2000, 500), -2) * 0.001)

KtV_cal(pre.BUN = df$pre.BUN, post.BUN = df$post.BUN, time = df$time, post.weight = df$post.weight, volume = df$volume)
#>  [1] 0.87 0.95 1.03 1.00 1.04 0.88 0.94 1.25 0.93 0.99
KtV_cal(pre.BUN = "pre.BUN", post.BUN = "post.BUN", time = "time", post.weight = "post.weight", volume = "volume", data = df)
#>  [1] 0.87 0.95 1.03 1.00 1.04 0.88 0.94 1.25 0.93 0.99
```
