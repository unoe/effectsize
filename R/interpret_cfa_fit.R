#' Interpret of indices of CFA / SEM goodness of fit
#'
#' Interpretation of indices of fit found in confirmatory analysis or structural equation modelling, such as RMSEA, CFI, NFI, IFI, etc.
#'
#' @param x vector of values, or an object of class `lavaan`.
#' @param rules Can be `"default"` or custom set of [rules()].
#' @inheritParams interpret
#'
#' @inherit performance::model_performance.lavaan details
#' @inherit performance::model_performance.lavaan references
#'
#' @details
#' ## Indices of fit
#' - **Chisq**: The model Chi-squared assesses overall fit and the discrepancy between the sample and fitted covariance matrices. Its p-value should be > .05 (i.e., the hypothesis of a perfect fit cannot be rejected). However, it is quite sensitive to sample size.
#' - **GFI/AGFI**: The (Adjusted) Goodness of Fit is the proportion of variance accounted for by the estimated population covariance. Analogous to R2. The GFI and the AGFI should be > .95 and > .90, respectively.
#' - **NFI/NNFI/TLI**: The (Non) Normed Fit Index. An NFI of 0.95, indicates the model of interest improves the fit by 95\% relative to the null model. The NNFI (also called the Tucker Lewis index; TLI) is preferable for smaller samples. They should be > .90 (Byrne, 1994) or > .95 (Schumacker & Lomax, 2004).
#' - **CFI**: The Comparative Fit Index is a revised form of NFI. Not very sensitive to sample size (Fan, Thompson, & Wang, 1999). Compares the fit of a target model to the fit of an independent, or null, model. It should be > .90.
#' - **RMSEA**: The Root Mean Square Error of Approximation is a parsimony-adjusted index. Values closer to 0 represent a good fit. It should be < .08 or < .05. The p-value printed with it tests the hypothesis that RMSEA is less than or equal to .05 (a cutoff sometimes used for good fit), and thus should be not significant.
#' - **RMR/SRMR**: the (Standardized) Root Mean Square Residual represents the square-root of the difference between the residuals of the sample covariance matrix and the hypothesized model. As the RMR can be sometimes hard to interpret, better to use SRMR. Should be < .08.
#' - **RFI**: the Relative Fit Index, also known as RHO1, is not guaranteed to vary from 0 to 1. However, RFI close to 1 indicates a good fit.
#' - **IFI**: the Incremental Fit Index (IFI) adjusts the Normed Fit Index (NFI) for sample size and degrees of freedom (Bollen's, 1989). Over 0.90 is a good fit, but the index can exceed 1.
#' - **PNFI**: the Parsimony-Adjusted Measures Index. There is no commonly agreed-upon cutoff value for an acceptable model for this index. Should be > 0.50.
#'
#' See the documentation for \code{\link[lavaan:fitmeasures]{fitmeasures()}}.
#'
#'
#' ## What to report
#' For structural equation models (SEM), Kline (2015) suggests that at a minimum the following indices should be reported: The model **chi-square**, the **RMSEA**, the **CFI** and the **SRMR**.
#'
#' @note When possible, it is recommended to report dynamic cutoffs of fit
#'   indices. See https://dynamicfit.app/cfa/.
#'
#'
#' @examples
#' interpret_gfi(c(.5, .99))
#' interpret_agfi(c(.5, .99))
#' interpret_nfi(c(.5, .99))
#' interpret_nnfi(c(.5, .99))
#' interpret_cfi(c(.5, .99))
#' interpret_rmsea(c(.07, .04))
#' interpret_srmr(c(.5, .99))
#' interpret_rfi(c(.5, .99))
#' interpret_ifi(c(.5, .99))
#' interpret_pnfi(c(.5, .99))
#'
#' # Structural Equation Models (SEM)
#' if (require("lavaan")) {
#'   structure <- " ind60 =~ x1 + x2 + x3
#'                  dem60 =~ y1 + y2 + y3
#'                  dem60 ~ ind60 "
#'   model <- lavaan::sem(structure, data = PoliticalDemocracy)
#'   # interpret(model)  # Not working until new performance is up
#' }
#' @references
#' - Awang, Z. (2012). A handbook on SEM. Structural equation modeling.
#' - Byrne, B. M. (1994). Structural equation modeling with EQS and EQS/Windows. Thousand Oaks, CA: Sage Publications.
#' - Tucker, L. R., \& Lewis, C. (1973). The reliability coefficient for maximum likelihood factor analysis. Psychometrika, 38, 1-10.
#' - Schumacker, R. E., \& Lomax, R. G. (2004). A beginner's guide to structural equation modeling, Second edition. Mahwah, NJ: Lawrence Erlbaum Associates.
#' - Fan, X., B. Thompson, \& L. Wang (1999). Effects of sample size, estimation method, and model specification on structural equation modeling fit indexes. Structural Equation Modeling, 6, 56-83.
#' - Kline, R. B. (2015). Principles and practice of structural equation modeling. Guilford publications.
#'
#' @export
interpret_gfi <- function(x, rules = "default") {
  rules <- .match.rules(
    rules,
    list(
      default = rules(c(0.95), c("poor", "satisfactory"), name = "default", right = FALSE)
    )
  )

  interpret(x, rules)
}


#' @rdname interpret_gfi
#' @export
interpret_agfi <- function(x, rules = "default") {
  rules <- .match.rules(
    rules,
    list(
      default = rules(c(0.90), c("poor", "satisfactory"), name = "default", right = FALSE)
    )
  )

  interpret(x, rules)
}


#' @rdname interpret_gfi
#' @export
interpret_nfi <- function(x, rules = "byrne1994") {
  rules <- .match.rules(
    rules,
    list(
      byrne1994 = rules(c(0.90), c("poor", "satisfactory"), name = "byrne1994", right = FALSE),
      schumacker2004 = rules(c(0.95), c("poor", "satisfactory"), name = "schumacker2004", right = FALSE)
    )
  )

  interpret(x, rules)
}

#' @rdname interpret_gfi
#' @export
interpret_nnfi <- interpret_nfi


#' @rdname interpret_gfi
#' @export
interpret_cfi <- function(x, rules = "default") {
  rules <- .match.rules(
    rules,
    list(
      default = rules(c(0.90), c("poor", "satisfactory"), name = "default", right = FALSE)
    )
  )

  interpret(x, rules)
}




#' @rdname interpret_gfi
#' @export
interpret_rmsea <- function(x, rules = "default") {
  rules <- .match.rules(
    rules,
    list(
      default = rules(c(0.05), c("satisfactory", "poor"), name = "default"),
      awang2012 = rules(c(0.05, 0.08), c("good", "satisfactory", "poor"), name = "awang2012")
    )
  )

  interpret(x, rules)
}


#' @rdname interpret_gfi
#' @export
interpret_srmr <- function(x, rules = "default") {
  rules <- .match.rules(
    rules,
    list(
      default = rules(c(0.08), c("satisfactory", "poor"), name = "default")
    )
  )

  interpret(x, rules)
}

#' @rdname interpret_gfi
#' @export
interpret_rfi <- function(x, rules = "default") {
  rules <- .match.rules(
    rules,
    list(
      default = rules(c(0.90), c("poor", "satisfactory"), name = "default", right = FALSE)
    )
  )

  interpret(x, rules)
}

#' @rdname interpret_gfi
#' @export
interpret_ifi <- function(x, rules = "default") {
  rules <- .match.rules(
    rules,
    list(
      default = rules(c(0.90), c("poor", "satisfactory"), name = "default", right = FALSE)
    )
  )

  interpret(x, rules)
}

#' @rdname interpret_gfi
#' @export
interpret_pnfi <- function(x, rules = "default") {
  rules <- .match.rules(
    rules,
    list(
      default = rules(c(0.50), c("poor", "satisfactory"), name = "default")
    )
  )

  interpret(x, rules)
}


# lavaan ------------------------------------------------------------------

#' @rdname interpret_gfi
#' @export
interpret.lavaan <- function(x, ...) {
  interpret(performance::model_performance(x, ...), ...)
}

#' @rdname interpret_gfi
#' @export
interpret.performance_lavaan <- function(x, ...) {
  table <- data.frame(Name = c(), Value = c(), Interpretation = c(), Threshold = c())

  # GFI
  if ("GFI" %in% names(x)) {
    table <- rbind(
      table,
      data.frame(
        Name = "GFI",
        Value = x$GFI,
        Interpretation = interpret_gfi(x$GFI),
        Threshold = 0.95
      )
    )
  }

  # AGFI
  if ("AGFI" %in% names(x)) {
    table <- rbind(
      table,
      data.frame(
        Name = "AGFI",
        Value = x$AGFI,
        Interpretation = interpret_agfi(x$AGFI),
        Threshold = 0.90
      )
    )
  }

  # NFI
  if ("NFI" %in% names(x)) {
    table <- rbind(
      table,
      data.frame(
        Name = "NFI",
        Value = x$NFI,
        Interpretation = interpret_nfi(x$NFI, rules = "byrne1994"),
        Threshold = 0.90
      )
    )
  }

  # NNFI
  if ("NNFI" %in% names(x)) {
    table <- rbind(
      table,
      data.frame(
        Name = "NNFI",
        Value = x$NNFI,
        Interpretation = interpret_nnfi(x$NNFI, rules = "byrne1994"),
        Threshold = 0.90
      )
    )
  }

  # CFI
  if ("CFI" %in% names(x)) {
    table <- rbind(
      table,
      data.frame(
        Name = "CFI",
        Value = x$CFI,
        Interpretation = interpret_cfi(x$CFI),
        Threshold = 0.90
      )
    )
  }

  # RMSEA
  if ("RMSEA" %in% names(x)) {
    table <- rbind(
      table,
      data.frame(
        Name = "RMSEA",
        Value = x$RMSEA,
        Interpretation = interpret_rmsea(x$RMSEA),
        Threshold = 0.05
      )
    )
  }

  # SRMR
  if ("SRMR" %in% names(x)) {
    table <- rbind(
      table,
      data.frame(
        Name = "SRMR",
        Value = x$SRMR,
        Interpretation = interpret_srmr(x$SRMR),
        Threshold = 0.08
      )
    )
  }

  # RFI
  if ("RFI" %in% names(x)) {
    table <- rbind(
      table,
      data.frame(
        Name = "RFI",
        Value = x$RFI,
        Interpretation = interpret_rfi(x$RFI),
        Threshold = 0.90
      )
    )
  }

  # IFI
  if ("IFI" %in% names(x)) {
    table <- rbind(
      table,
      data.frame(
        Name = "IFI",
        Value = x$IFI,
        Interpretation = interpret_ifi(x$IFI),
        Threshold = 0.90
      )
    )
  }

  # IFI
  if ("PNFI" %in% names(x)) {
    table <- rbind(
      table,
      data.frame(
        Name = "PNFI",
        Value = x$PNFI,
        Interpretation = interpret_pnfi(x$PNFI),
        Threshold = 0.50
      )
    )
  }

  table
}
