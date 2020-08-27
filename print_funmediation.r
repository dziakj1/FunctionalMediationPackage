#' print.funmediation:  Print output from a model that was fit by the funmediation function.
#'
#' @param x The funmediation object (output of the funmediation function)
#' @param ... Further arguments currently not supported
#'
#' @import tvem
#' @importFrom utils getS3method
#'
#' @exportMethod print
#' @export
#' @method print funmediation

print.funmediation <- function(x, ...) {
  cat("======================================================= \n");
  cat("Functional Regression Mediation Function Output \n");
  cat("======================================================= \n");
  cat("Indirect effect bootstrap estimate:\n");
  cat(x$bootstrap_results$indirect_effect_boot_estimate);
  cat("\nIndirect effect bootstrap confidence interval:");
  cat("\n... by normal method:\n");
  cat(c(round(x$bootstrap_results$indirect_effect_boot_norm_lower,4), ", ",
        round(x$bootstrap_results$indirect_effect_boot_norm_upper,4)));
  cat("\n... by percentile method:\n");
  cat(c(round(x$bootstrap_results$indirect_effect_boot_perc_lower,4), ", ",
          round(x$bootstrap_results$indirect_effect_boot_perc_upper,4)));
  cat("\nComputation time:\n");
  print(x$bootstrap_results$time_required);
  cat("======================================================= \n");
  cat("TVEM Model for Predicting Mediator from Treatment:\n");
  workaround_print <- getS3method("print", "tvem");
  workaround_print(x$original_results$tvem_XM_details,ornate=FALSE);
  cat("======================================================= \n");
  cat("Functional Mediation Model for Predicting Mediator from Treatment: \n");
  print(x$original_results$funreg_MY_details);
  cat("======================================================= \n");
  cat("Scalar terms:\n")
  temp <- x$original_results$funreg_MY_details$coefficients;
  print(temp[-grep(x=names(temp),pattern=":")]);
  cat("======================================================= \n");
  cat("Parametric model for Predicting Outcome from Treatment and Mediator: \n");
  print(summary(x$original_results$direct_effect_details));
  cat("======================================================= \n");
  if(!is.null(x$original_results$tvem_IC_table)) {
    cat("ICs table for selecting number of interior knots in TVEM:\n");
    print(x$original_results$tvem_IC_table);
    cat("======================================================= \n");
  }
  if(!is.null(x$bootstrap_results$num_knots_from_bootstraps)) {
    cat("Numbers of interior knots selected in bootstrap samples:\n");
    print(x$bootstrap_results$num_knots_from_bootstraps);
    cat("======================================================= \n");
  }
}
