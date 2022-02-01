#' Calculate BMI
#' @description
#' Calculate Body mass index (BMI) based on height and weight.
#' Determine weight from height and BMI
#' @param height The column name or number containing the height value, if a vector or dataframe of height values is specified.
#' @param weight The column name or number containing the weight value, if a vector or dataframe of height values is specified.
#' @param BMI numeric value. BMI, want to find weight.
#' @param data data frame.
#' @param digits Significant digits of the value to be output. The number of decimal places to display. If you want to display all calculated values without significant digits, specify NULL.
#' @param h.unit Select the unit of height in meters or centimeters.
#' @param w.unit Select the unit of weight in kg or g.
#' @details
#' Height and weight values have to be numerical.
#' BMI is calculated by the following formula.
#' \deqn{BMI = weight(kg) / height(m) ^ 2}
#' Height and weight must be a single value or a vector of equal length.
#' If one is a single value and the other is a vector, the single value will be recycled and used.
#' @examples
#' BMI_cal(1.75, 65)
#' height <- c(165, 170, 175)
#' weight <- c(60, 65, 70)
#' BMI_cal(height, weight, h.unit = "cm")
#' @rdname BMI_cal
#' @export
BMI_cal <- function(height,
                    weight,
                    data = NULL,
                    digits = 1,
                    h.unit = c("m", "cm"),
                    w.unit = c("kg", "g")
){
  h.unit <- match.arg(h.unit)
  w.unit <- match.arg(w.unit)

  digits_check(digits = digits)
  data_check(height, weight, .data = data)

  if(!is.null(data)){
    height <- data[height]
    weight <- data[weight]
  }

  height <- unlist(height)
  weight <- unlist(weight)

  value_check(height, weight)

  if(h.unit == "cm") height <- height * 0.01
  if(w.unit == "g") weight <- weight * 0.001

  BMI <- unname(weight / (height ^ 2))

  if(!is.null(digits)){
    round(BMI, digits = digits)
  }else{
    BMI
  }
}

#' @rdname BMI_cal
#' @export
weight_cal <- function(height, BMI = 22, data = NULL, digits = 1, h.unit = c("m", "cm")){
  h.unit <- match.arg(h.unit)
  data_check(height, .data = data)
  if(!is.null(data)){
    height <- data[height]
  }
  height <- unlist(height)
  value_check(height, BMI)
  if(h.unit == "cm") height <- height * 0.01

  weight <- unname(BMI * (height ^ 2))

  if(!is.null(digits)){
    round(weight, digits = digits)
  }else{
    weight
  }
}
