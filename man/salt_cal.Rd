% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/salt_cal.R
\name{UCrV_24h_cal}
\alias{UCrV_24h_cal}
\alias{UNaV_24h_cal}
\alias{salt_24h_cal}
\title{Calculate the estimated daily salt intake from the laboratory data.}
\usage{
UCrV_24h_cal(
  age,
  weight,
  height,
  data = NULL,
  digits = NULL,
  h.unit = c("m", "cm"),
  w.unit = c("kg", "g")
)

UNaV_24h_cal(
  SUNa,
  SUCr,
  age,
  weight,
  height,
  data = NULL,
  digits = NULL,
  h.unit = c("m", "cm"),
  w.unit = c("kg", "g")
)

salt_24h_cal(
  SUNa,
  SUCr,
  age,
  weight,
  height,
  data = NULL,
  digits = NULL,
  h.unit = c("m", "cm"),
  w.unit = c("kg", "g")
)
}
\arguments{
\item{age}{The column name or number containing the age value, if a vector or dataframe of age values is specified.}

\item{weight}{The column name or number containing the weight value, if a vector or dataframe of height values is specified.}

\item{height}{The column name or number containing the height value, if a vector or dataframe of height values is specified.}

\item{data}{data frame.}

\item{digits}{Significant digits of the value to be output. The number of decimal places to display. If you want to display all calculated values without significant digits, specify NULL.}

\item{h.unit}{Select the unit of height in meters or centimeters.}

\item{w.unit}{Select the unit of weight in kg or g.}

\item{SUNa}{The column name or number containing the value of Na concentration in the spot voiding urine, if a vector or dataframe of height values is specified.}

\item{SUCr}{The column name or number containing the value of creatinine concentration in the spot voiding urine, if a vector or dataframe of height values is specified.}
}
\description{
\code{salt_24h_cal} calculate the estimated daily salt intake using age, weight, height, urine natrium at any time, and urine creatinine at any time.
\code{UCrV_24h_cal} calculate the estimated 24-hour urinary creatinine excretion using age, weight, height.
\code{UNaV_24h_cal} calculate the estimated 24-hour urinary natrium excretion using age, weight, height, urine natrium at any time, and urine creatinine at any time.
}
\note{
The calculation is based on Tanaka's approximate formula shown in Ref.
}
\references{
Tanaka T, Okamura T, Miura K, Kadowaki T, Ueshima H, Nakagawa H, Hashimoto T. A simple method to estimate populational 24-h urinary sodium and potassium excretion using a casual urine specimen. J Hum Hypertens. 2002 Feb;16(2):97-103. doi: 10.1038/sj.jhh.1001307. PMID: 11850766.
}
