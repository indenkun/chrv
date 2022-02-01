digits_check <- function(digits){
  if(is.null(digits) || (is.numeric(digits) && length(digits) == 1)){
    # do not nothing.
  }else{
    stop("Significant figures should be specified as numeric or null.")
  }
}

data_check <- function(..., .data){
  if(!is.null(.data) && !is.data.frame(.data)){
    stop("A non-data frame is specified where data is specified.")
  }
  if(is.data.frame(.data)){
    check_list <- list(...)
    obj_l <- sapply(check_list, length)
    if(!all(obj_l == 1)){
      stop("If a data frame is specified, only one value can be entered for each.")
    }else{
      data_n <- ncol(.data)
      data_colname <- colnames(.data)
      is_numeric_list <- sapply(check_list, is.numeric)
      if(all(is_numeric_list)){
        if(all(unlist(check_list) %in% 1:data_n) && length(unique(unlist(check_list))) == length(check_list)){
          # do not nothing.
        }else{
          stop("It seems that a column that does not exist in the column range has been specified.")
        }
      }else if(all(!is_numeric_list)){
        if(all(unlist(check_list) %in% data_colname) && length(unique(unlist(check_list))) == length(check_list)){
          # do not nothing.
        }else{
          stop("It seems that a column that does not exist in the column range has been specified.")
        }
      }else{
        stop("Please unify whether to specify by column name or by column number.")
      }
    }
  }
}

value_check <- function(...){
  check_list <- list(...)
  ans_length <- sapply(check_list, length)
  if(!all(ans_length[-1] == ans_length[1]) && length(unique(ans_length)) >= 3){
    stop("All vectors must have the same length except for vectors of length 1.")
  }
  if(any(ans_length == 0)){
    stop("The input value contains a vector with zero length.")
  }
  ans_num <- sapply(check_list, is.numeric)
  if(!all(ans_num)){
    stop("Unable to calculate because the value entered is not a number.")
  }
}

sex_check <- function(male, female){
  if(length(male) != 1 || length(female) != 1){
    stop("Please specify one for each sex.")
  }
  if(male == female){
    stop("Please specify a different gender for each.")
  }
}

length_check <- function(...){
  check_list <- list(...)
  ans_length <- sapply(check_list, length)
  if(!all(ans_length[-1] == ans_length[1]) && unique(ans_length) >= 3){
    stop("All vectors must have the same length except for vectors of length 1.")
  }
}

numeric_check <- function(...){
  check_list <- list(...)
  ans_num <- sapply(check_list, is.numeric)
  if(!all(ans_num)){
    stop("Unable to calculate because the value entered is not a number.")
  }
}
