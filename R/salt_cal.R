#' Calculate the estimated daily salt intake from the laboratory data.
#' @description
#' \code{salt_24h_cal} calculate the estimated daily salt intake using age, weight, height, urine natrium at any time, and urine creatinine at any time.
#' \code{UCrV_24h_cal} calculate the estimated 24-hour urinary creatinine excretion using age, weight, height.
#' \code{UNaV_24h_cal} calculate the estimated 24-hour urinary natrium excretion using age, weight, height, urine natrium at any time, and urine creatinine at any time.
#' @param age The column name or number containing the age value, if a vector or dataframe of age values is specified.
#' @param weight The column name or number containing the weight value, if a vector or dataframe of height values is specified.
#' @param height The column name or number containing the height value, if a vector or dataframe of height values is specified.
#' @param SUNa The column name or number containing the value of Na concentration in the spot voiding urine, if a vector or dataframe of height values is specified.
#' @param SUCr The column name or number containing the value of creatinine concentration in the spot voiding urine, if a vector or dataframe of height values is specified.
#' @param data data frame.
#' @param digits Significant digits of the value to be output. The number of decimal places to display. If you want to display all calculated values without significant digits, specify NULL.
#' @param h.unit Select the unit of height in meters or centimeters.
#' @param w.unit Select the unit of weight in kg or g.
#' @note
#' The calculation is based on Tanaka's approximate formula shown in Ref.
#' @references
#' Tanaka T, Okamura T, Miura K, Kadowaki T, Ueshima H, Nakagawa H, Hashimoto T. A simple method to estimate populational 24-h urinary sodium and potassium excretion using a casual urine specimen. J Hum Hypertens. 2002 Feb;16(2):97-103. doi: 10.1038/sj.jhh.1001307. PMID: 11850766.
#' @export
#' @rdname salt_cal

UCrV_24h_cal <- function(age, weight, height,
                         data = NULL,
                         digits = NULL,
                         h.unit = c("m", "cm"),
                         w.unit = c("kg", "g")){
  h.unit <- match.arg(h.unit)
  w.unit <- match.arg(w.unit)

  digits_check(digits = digits)
  data_check(age, weight, height, .data = data)

  if(!is.null(data)){
    height <- data[height]
    weight <- data[weight]
    age <- data[age]
  }

  age <- unlist(age)
  weight <- unlist(weight)
  height <- unlist(height)

  value_check(age, weight, height)

  if(h.unit == "m") height <- height * 100
  if(w.unit == "g") weight <- weight * 0.001

  UCr_24h <- -2.04 * age + 14.89 * weight + 16.14 * height - 2244.45
  if(!is.null(digits) && is.numeric(digits)){
    unname(round(UCr_24h, digits = digits))
  }else if(is.null(digits)){
    unname(UCr_24h)
  }
}

#' @export
#' @rdname salt_cal

UNaV_24h_cal <- function(SUNa, SUCr, age, weight, height,
                         data = NULL,
                         digits = NULL,
                         h.unit = c("m", "cm"),
                         w.unit = c("kg", "g")){
  h.unit <- match.arg(h.unit)
  w.unit <- match.arg(w.unit)

  digits_check(digits = digits)
  data_check(SUNa, SUCr, age, weight, height, .data = data)

  if(!is.null(data)){
      SUNa <- data[SUNa]
      SUCr <- data[SUCr]
  }

  SUNa <- unlist(SUNa)
  SUCr <- unlist(SUCr)

  UCrV_24h <- UCrV_24h_cal(age = age, weight = weight, height = height,
                           data = data,
                           digits = NULL,
                           h.unit = h.unit,
                           w.unit = w.unit)


  value_check(SUNa, SUCr, UCrV_24h)

  UNaV_24h <- 21.98 *((SUNa / SUCr / 10 * UCrV_24h) ^ 0.392)

  if(!is.null(digits)){
    unname(round(UNaV_24h, digits = digits))
  }else{
    unname(UNaV_24h)
  }
}

#' @export
#' @rdname salt_cal
salt_24h_cal <- function(SUNa, SUCr,age, weight, height,
                         data = NULL,
                         digits = NULL,
                         h.unit = c("m", "cm"),
                         w.unit = c("kg", "g")){
  h.unit <- match.arg(h.unit)
  w.unit <- match.arg(w.unit)

  digits_check(digits = digits)

  UNaV_24h <- UNaV_24h_cal(SUNa = SUNa, SUCr = SUCr, age = age, weight = weight, height = height,
                           data = data,
                           digits = NULL,
                           h.unit = h.unit,
                           w.unit = w.unit)

  salt_24h <- UNaV_24h / 17

  if(!is.null(digits)){
    round(salt_24h, digits = digits)
  }else
    salt_24h
}
