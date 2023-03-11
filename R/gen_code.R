#' Generate Code
#'
#' @param object a vector, tibble, data.frame, list, matrix, or array
#'
#' @return a string of code to build the object
#' @export
#'
#' @examples
#' t1 <- data.frame(id = 1:6, sex = rep(c("M", "F"),3))
#' l1 <- as.list(rnorm(12))
#' gen_code(t1)
#' gen_code(l1)
gen_code <- function(object){
  UseMethod("gen_code")
}


#' @rdname gen_code
#'
#' @export
gen_code.double <- function(object){
  cd <- paste0("as.numeric(c(", paste(object, collapse = ", "), "))")
  return(cd)
}

#' @rdname gen_code
#'
#' @export
gen_code.integer <- function(object){
  cd <- paste0("as.integer(c(", paste(object, collapse = ", "), "))")
  return(cd)
}

#' @rdname gen_code
#'
#' @export
gen_code.logical <- function(object){
  cd <- paste0("as.logical(c(", paste(object, collapse = ", "), "))")
  return(cd)
}

#' @rdname gen_code
#'
#' @export
gen_code.character <- function(object){
  cd <- paste0("c('", paste(object, collapse = "', '"), "')")
  return(cd)
}

#' @rdname gen_code
#'
#' @export
gen_code.factor <- function(object){
  lvs <- levels(object)
  cd <- paste0("factor(c('", paste(object, collapse = "', '"), "'), levels = ", gen_code(lvs))
  if(is.ordered(object)) cd <- paste0(cd,  ", ordered = TRUE")
  cd <- paste0(cd, ")")
  return(cd)

}

#' @rdname gen_code
#'
#' @export
gen_code.Date <- function(object){
  cd <- paste0("as.Date(", paste0("c('", paste(object, collapse = "', '"), "')"), ")")
  return(cd)
}

#' @rdname gen_code
#'
#' @export
gen_code.POSIXct <- function(object){
  cd <- paste0("as.POSIXct(", paste0("c('", paste(object, collapse = "', '"), "')"), ")")
  return(cd)
}

#' @rdname gen_code
#'
#' @export
gen_code.difftime <- function(object){
  un <- attr(object, "units")
  cd <- paste0("as.difftime(c(", paste0(object, collapse = ", "), "), units =  '", un, "')")
  return(cd)

}

#' @rdname gen_code
#'
#' @export
gen_code.list <- function(object){

  l2 <- lapply(object, gen_code)
  if(!is.null(names(object))) l2 <- mapply(function(x, y) paste(x,  "=", y), names(object), l2, SIMPLIFY = FALSE)
  cd <- paste0("list(", paste0(l2, collapse = ", ") ,")")

  return(cd)
}

#' @rdname gen_code
#'
#' @export
gen_code.tbl_df <- function(object){

  l2 <- lapply(object, gen_code)
  l2 <- mapply(function(x, y) paste(x,  "=", y), names(object), l2, SIMPLIFY = FALSE)
  cd <- paste0("tibble(", paste0(l2, collapse = ", ") ,")")

  return(cd)

}

#' @rdname gen_code
#'
#' @export
gen_code.data.frame <- function(object){

  l2 <- lapply(object, gen_code)
  l2 <- mapply(function(x, y) paste(x,  "=", y), names(object), l2, SIMPLIFY = FALSE)
  cd <- paste0("data.frame(", paste0(l2, collapse = ", "))
  if(any(grepl("\\D", rownames(object)))) cd <- paste0(cd, ", row.names = c('", paste0(rownames(object), collapse = "', '"), "')")
  cd <- paste0(cd, ")")

  return(cd)

}

#' @rdname gen_code
#'
#' @export
gen_code.matrix <- function(object){

  l2 <- apply(object, 2, gen_code)
  cd <- paste0("matrix(c(", paste0(l2, collapse = ", "), "), ncol = ", length(l2), ")")
  return(cd)

}

#' @rdname gen_code
#'
#' @export
gen_code.array <- function(object){

  dimx <- dim(object)
  l1 <- length(dimx)
  dimx <- paste0("dim = c(", paste(dimx, collapse = ", "), ")")

  l2 <- apply(object, l1, gen_code)
  cd <- paste0("array(c(", paste0(l2, collapse = ", "), "), ", dimx, ")")
  return(cd)

}


