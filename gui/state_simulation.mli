(******************************************************************************)
(*  _  __ * The Kappa Language                                                *)
(* | |/ / * Copyright 2010-2020 CNRS - Harvard Medical School - INRIA - IRIF  *)
(* | ' /  *********************************************************************)
(* | . \  * This file is distributed under the terms of the                   *)
(* |_|\_\ * GNU Lesser General Public License Version 3                       *)
(******************************************************************************)

type t

val t_simulation_info : t -> Api_types_j.simulation_info option

type model = t

val dummy_model : model
val model : model React.signal
val model_simulation_info : model -> Api_types_j.simulation_info option

type model_state = STOPPED | INITALIZING | RUNNING | PAUSED

val model_state_to_string : model_state -> string
val model_simulation_state : t -> model_state

(* run on application init *)
val init : unit -> unit Lwt.t
val refresh : unit -> unit Api.lwt_result

val eval_with_sim_manager :
  label:string ->
  (Api.concrete_manager -> t -> 'a Api.lwt_result) ->
  'a Api.lwt_result
(** [eval_with_sim_manager ~label handler] evaluates the function [handler] applied to the [concrete_manager] of current project and current [simulation_state] *)

val eval_with_sim_manager_and_info :
  label:string ->
  ?stopped:(Api.concrete_manager -> 'a Api.lwt_result) ->
  ?initializing:(Api.concrete_manager -> 'a Api.lwt_result) ->
  ?ready:
    (Api.concrete_manager -> Api_types_j.simulation_info -> 'a Api.lwt_result) ->
  unit ->
  'a Api.lwt_result
(** [eval_with_sim_manager_and_info ~label ~stopped ~initializing ~ready] evaluates the function in argument matching the current [simulation_state], applied to the [concrete_manager] of current project *)

val eval_when_ready :
  label:string ->
  ?handler:(unit Api.result -> unit Lwt.t) ->
  (Api.concrete_manager -> unit Api.lwt_result) ->
  unit

val continue_simulation : string -> unit Api.lwt_result
val pause_simulation : unit -> unit Api.lwt_result
val stop_simulation : unit -> unit Api.lwt_result
val start_simulation : Api_types_j.simulation_parameter -> unit Api.lwt_result
val intervene_simulation : string -> string Api.lwt_result
