#' Calculate Kt/V
#' @description
#' Calculate variable-volume single-pool (VVSP) Kt/V from BUN before and after dialysis, dialysis time, post-dialysis weight, and ultrafiltration Volume.
#' @param pre.BUN a (non-empty) numeric vector of data values. pre dialysis BUN (mg/dL).
#' @param post.BUN a (non-empty) numeric vector of data values. post dialysis BUN (mg/dL).
#' @param time a (non-empty) numeric vector of data values. Duration of dialysis (hours).
#' @param post.weight a (non-empty) numeric vector of data values. Ultrafiltration volume (L).
#' @param volume a (non-empty) numeric vector of data values. post dialysis weight (kg).
#' @param data data frame.
#' @param digits integer indicating the number of decimal places. If you want to display all calculated values without significant digits, specify NULL.
#' @details
#' Daugirdas' formula is used to calculate Kt/V.
#' @references
#' Daugirdas JT. Second generation logarithmic estimates of single-pool variable volume Kt/V: an analysis of error. J Am Soc Nephrol. 1993 Nov;4(5):1205-13. doi: 10.1681/ASN.V451205. PMID: 8305648.
#' @export

KtV_cal <- function(pre.BUN, post.BUN, time, post.weight, volume, data = NULL, digits = 2){
  digits_check(digits = digits)
  data_check(pre.BUN, post.BUN, time, post.weight, volume, .data = data)
  if(!is.null(data)){
    pre.BUN <- data[pre.BUN]
    post.BUN <- data[post.BUN]
    time <- data[time]
    post.weight <- data[post.weight]
    volume <- data[volume]
  }
  pre.BUN <- unlist(pre.BUN)
  post.BUN <- unlist(post.BUN)
  time <- unlist(time)
  post.weight <- unlist(post.weight)
  volume <- unlist(volume)
  value_check(pre.BUN, post.BUN, time, post.weight, volume)

  KtV <- -log((post.BUN / pre.BUN) - (0.008 * time)) + ((4 - (3.5 * post.BUN / pre.BUN)) * volume / post.weight)
  if(is.null(digits)) unname(KtV)
  else unname(round(KtV, digits = digits))
}
