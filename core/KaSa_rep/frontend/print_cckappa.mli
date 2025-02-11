val trace : bool
val local_trace : bool
val print_kasim_site : unit -> string

val print_mixture :
  Remanent_parameters_sig.parameters ->
  Exception_without_parameter.exceptions_caught_and_uncaught ->
  Cckappa_sig.kappa_handler ->
  Cckappa_sig.mixture ->
  Exception_without_parameter.exceptions_caught_and_uncaught

val print_compil :
  Remanent_parameters_sig.parameters ->
  Exception_without_parameter.exceptions_caught_and_uncaught ->
  Cckappa_sig.kappa_handler ->
  Cckappa_sig.compil ->
  Exception_without_parameter.exceptions_caught_and_uncaught
