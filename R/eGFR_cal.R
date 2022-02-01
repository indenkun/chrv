#' Calculate eGFR
#' @description
#' Calculate estimation of glomerular filtration rate (eGFR) based on value of Creatinine or Cyc-C and age, sex.
#' @param value The column name or number containing the value of Creatinine or Cyc-C, if a vector or dataframe of values is specified.
#' @param age The column name or number containing the age value, if a vector or dataframe of age values is specified.
#' @param sex The column name or value of sex, if a vector or dataframe of sex values is specified.
#' @param data data frame.
#' @param digits Significant digits of the value to be output. The number of decimal places to display. If you want to display all calculated values without significant digits, specify NULL.
#' @param male The value that specifies the gender as male. The default value is "man".
#' @param female The value that specifies the gender as female. The default value is "woman".
#' @param v.type Select whether the value being entered is Creatinine or Cyc-C.
#' @details
#' Values of Creatinine or Cyc-c and Age values have to be numerical.
#' If one or two is a single value and the other is a vector, the single value will be recycled and used.
#' @note
#' The calculation of eGFR is using the formula for Japanese.
#' @references
#' Matsuo S, Imai E, Horio M, Yasuda Y, Tomita K, Nitta K, Yamagata K, Tomino Y, Yokoyama H, Hishida A; Collaborators developing the Japanese equation for estimated GFR. Revised equations for estimated GFR from serum creatinine in Japan. Am J Kidney Dis. 2009 Jun;53(6):982-92. doi: 10.1053/j.ajkd.2008.12.034. Epub 2009 Apr 1. PMID: 19339088.
#'
#' Horio M, Imai E, Yasuda Y, Watanabe T, Matsuo S; Collaborators Developing the Japanese Equation for Estimated GFR. GFR estimation using standardized serum cystatin C in Japan. Am J Kidney Dis. 2013 Feb;61(2):197-203. doi: 10.1053/j.ajkd.2012.07.007. Epub 2012 Aug 11. PMID: 22892396.
#' @examples
#' eGFR_cal(1, 20, "man")
#' df <- data.frame(value = c(1, 1),
#'                  age = c(20, 80),
#'                  sex = c("M", "F"))
#' eGFR_cal("value", "age", "sex", df, male = "M", female = "F")
#' @export
eGFR_cal <- function(value, age, sex,
                     data = NULL,
                     digits = 1,
                     male = "male", female = "female",
                     v.type = c("Cr", "Cys-C")){
  v.type <- match.arg(v.type)

  digits_check(digits = digits)
  data_check(value, age, sex, .data = data)

  if(!is.null(data)){
    value <- data[value]
    age <- data[age]
    sex <- data[sex]
   }

  value <- unlist(value)
  age <- unlist(age)
  sex <- unlist(sex)

  sex_check(male, female)
  length_check(value, age, sex)
  numeric_check(value, age)

  eGFR <- unlist(unname(mapply(function(value, age, sex){
    if(sex == male){
      if(v.type == "Cr") 194 * value ^ -1.094 * age ^ -0.287
      else if(v.type == "Cys-C") (104 * value - 1.019 * 0.996 * age) - 8
      else return(NA)
    }else if(sex == female){
      if(v.type == "Cr") 194 * value ^ -1.094 * age ^ -0.287 * 0.739
      else if(v.type == "Cys-C") (104 * value - 1.019 * 0.996 * age * 0.929) - 8
      else return(NA)
    }else{
      return(NA)
    }}, value, age, sex)))

  if(!is.null(digits)){
    round(eGFR, digits = digits)
  }else{
    eGFR
  }
}
