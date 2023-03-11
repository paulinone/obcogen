#' Generate Code
#'
#' Generates a String of Code to build an object
#'
#' @param object a vector, tibble, data.frame, list, matrix, or array
#'
#' @return a string of code to build the object
#' @export
#'
#' @examples
#' t1 <- data.frame(id = 1:6, sex = rep(c("M", "F"),3))
#' l1 <- as.list(rnorm(12))
#' code_gen(t1)
#' code_gen(l1)
code_gen <- function(object){
  UseMethod("code_gen")
}


#' @rdname code_gen
#'
#' @export
code_gen.double <- function(object){
  cd <- paste0("as.numeric(c(", paste(object, collapse = ", "), "))")
  return(cd)
}

#' @rdname code_gen
#'
#' @export
code_gen.integer <- function(object){
  cd <- paste0("as.integer(c(", paste(object, collapse = ", "), "))")
  return(cd)
}

#' @rdname code_gen
#'
#' @export
code_gen.logical <- function(object){
  cd <- paste0("as.logical(c(", paste(object, collapse = ", "), "))")
  return(cd)
}

#' @rdname code_gen
#'
#' @export
code_gen.character <- function(object){
  cd <- paste0("c('", paste(object, collapse = "', '"), "')")
  return(cd)
}

#' @rdname code_gen
#'
#' @export
code_gen.factor <- function(object){
  lvs <- levels(object)
  cd <- paste0("factor(c('", paste(object, collapse = "', '"), "'), levels = ", code_gen(lvs))
  if(is.ordered(object)) cd <- paste0(cd,  ", ordered = TRUE")
  cd <- paste0(cd, ")")
  return(cd)

}

#' @rdname code_gen
#'
#' @export
code_gen.Date <- function(object){
  cd <- paste0("as.Date(", paste0("c('", paste(object, collapse = "', '"), "')"), ")")
  return(cd)
}

#' @rdname code_gen
#'
#' @export
code_gen.POSIXct <- function(object){
  cd <- paste0("as.POSIXct(", paste0("c('", paste(object, collapse = "', '"), "')"), ")")
  return(cd)
}

#' @rdname code_gen
#'
#' @export
code_gen.difftime <- function(object){
  un <- attr(object, "units")
  cd <- paste0("as.difftime(c(", paste0(object, collapse = ", "), "), units =  '", un, "')")
  return(cd)

}

#' @rdname code_gen
#'
#' @export
code_gen.list <- function(object){

  l2 <- lapply(object, code_gen)
  if(!is.null(names(object))) l2 <- mapply(function(x, y) paste(x,  "=", y), names(object), l2, SIMPLIFY = FALSE)
  cd <- paste0("list(", paste0(l2, collapse = ", ") ,")")

  return(cd)
}

#' @rdname code_gen
#'
#' @export
code_gen.tbl_df <- function(object){

  l2 <- lapply(object, code_gen)
  l2 <- mapply(function(x, y) paste(x,  "=", y), names(object), l2, SIMPLIFY = FALSE)
  cd <- paste0("tibble(", paste0(l2, collapse = ", ") ,")")

  return(cd)

}

#' @rdname code_gen
#'
#' @export
code_gen.data.frame <- function(object){

  l2 <- lapply(object, code_gen)
  l2 <- mapply(function(x, y) paste(x,  "=", y), names(object), l2, SIMPLIFY = FALSE)
  cd <- paste0("data.frame(", paste0(l2, collapse = ", "))
  if(any(grepl("\\D", rownames(object)))) cd <- paste0(cd, ", row.names = c('", paste0(rownames(object), collapse = "', '"), "')")
  cd <- paste0(cd, ")")

  return(cd)

}

#' @rdname code_gen
#'
#' @export
code_gen.matrix <- function(object){

  l2 <- apply(object, 2, code_gen)
  cd <- paste0("matrix(c(", paste0(l2, collapse = ", "), "), ncol = ", length(l2), ")")
  return(cd)

}

#' @rdname code_gen
#'
#' @export
code_gen.array <- function(object){

  dimx <- dim(object)
  l1 <- length(dimx)
  dimx <- paste0("dim = c(", paste(dimx, collapse = ", "), ")")

  l2 <- apply(object, l1, code_gen)
  cd <- paste0("array(c(", paste0(l2, collapse = ", "), "), ", dimx, ")")
  return(cd)

}


