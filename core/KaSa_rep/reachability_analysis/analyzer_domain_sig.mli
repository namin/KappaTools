(*
  * analyzer_sig.mli
  * openkappa
  * Jérôme Feret & Ly Kim Quyen, project Antique, INRIA Paris
  *
  * Creation: 2016, the 30th of January
  * Last modification: Time-stamp: <Aug 22 2018>
  *
  * Compute the relations between sites in the BDU data structures
  *
  * Copyright 2010,2011,2012,2013,2014,2015,2016 Institut National de Recherche
  * en Informatique et en Automatique.
  * All rights reserved.  This file is distributed
  * under the terms of the GNU Library General Public License *)

(** signature of abstract domains (with explicit communication) *)
module type Domain = sig
  type static_information
  type local_dynamic_information

  type dynamic_information = {
    local: local_dynamic_information;
    global: Analyzer_headers.global_dynamic_information;
  }

  val get_parameter : static_information -> Remanent_parameters_sig.parameters

  val get_global_dynamic_information :
    dynamic_information -> Analyzer_headers.global_dynamic_information

  val set_global_dynamic_information :
    Analyzer_headers.global_dynamic_information ->
    dynamic_information ->
    dynamic_information

  val initialize :
    Analyzer_headers.global_static_information ->
    Analyzer_headers.global_dynamic_information ->
    Exception.exceptions_caught_and_uncaught ->
    Exception.exceptions_caught_and_uncaught
    * static_information
    * dynamic_information
    * Communication.event list

  val complete_wake_up_relation :
    static_information ->
    Exception.exceptions_caught_and_uncaught ->
    Common_static.site_to_rules_tmp ->
    Exception.exceptions_caught_and_uncaught * Common_static.site_to_rules_tmp

  type 'a zeroary =
    static_information ->
    dynamic_information ->
    Exception.exceptions_caught_and_uncaught ->
    Exception.exceptions_caught_and_uncaught * dynamic_information * 'a

  type ('a, 'b) unary =
    static_information ->
    dynamic_information ->
    Exception.exceptions_caught_and_uncaught ->
    'a ->
    Exception.exceptions_caught_and_uncaught * dynamic_information * 'b

  type ('a, 'b, 'c) binary =
    static_information ->
    dynamic_information ->
    Exception.exceptions_caught_and_uncaught ->
    'a ->
    'b ->
    Exception.exceptions_caught_and_uncaught * dynamic_information * 'c

  type ('a, 'b, 'c, 'd) ternary =
    static_information ->
    dynamic_information ->
    Exception.exceptions_caught_and_uncaught ->
    'a ->
    'b ->
    'c ->
    Exception.exceptions_caught_and_uncaught * dynamic_information * 'd

  val add_initial_state :
    (Analyzer_headers.initial_state, Communication.event list) unary

  val is_enabled :
    ( Ckappa_sig.c_rule_id,
      Communication.precondition,
      Communication.precondition option )
    binary

  val apply_rule :
    ( Ckappa_sig.c_rule_id,
      Communication.precondition,
      Communication.precondition * Communication.event list )
    binary

  val apply_one_side_effect :
    ( Ckappa_sig.c_rule_id,
      (Ckappa_sig.c_agent_id
      * Ckappa_sig.c_agent_name
      * Ckappa_sig.c_site_name
      * Ckappa_sig.c_state)
      option
      * (Ckappa_sig.c_agent_name * Ckappa_sig.c_site_name * Ckappa_sig.c_state),
      Communication.precondition,
      Communication.precondition * Communication.event list )
    ternary

  val apply_event_list :
    (Communication.event list, Communication.event list) unary

  val stabilize : unit zeroary

  val export :
    ( ('static, 'dynamic) Analyzer_headers.kasa_state,
      ('static, 'dynamic) Analyzer_headers.kasa_state )
    unary

  val print :
    ?dead_rules:
      (Remanent_parameters_sig.parameters ->
      Exception.exceptions_caught_and_uncaught ->
      Ckappa_sig.c_rule_id ->
      Exception.exceptions_caught_and_uncaught * bool) ->
    (Loggers.t, unit) unary

  val maybe_reachable :
    ( Analyzer_headers.pattern_matching_flag,
      Cckappa_sig.mixture,
      Communication.precondition,
      Communication.precondition option )
    ternary

  val get_dead_rules :
    static_information ->
    dynamic_information ->
    Remanent_parameters_sig.parameters ->
    Exception.exceptions_caught_and_uncaught ->
    Ckappa_sig.c_rule_id ->
    Exception.exceptions_caught_and_uncaught * bool

  val get_side_effects :
    static_information ->
    dynamic_information ->
    Remanent_parameters_sig.parameters ->
    Exception.exceptions_caught_and_uncaught ->
    Ckappa_sig.c_rule_id ->
    Exception.exceptions_caught_and_uncaught * Ckappa_sig.side_effects option
end
