type 'a t
type 'a m = 'a t
type failure = Context.t -> TypeErrors.t

val return : 'a -> 'a m
val bind : 'a m -> ('a -> 'b m) -> 'b m
val pure : 'a m -> 'a m
val (let@) : 'a m -> ('a -> 'b m) -> 'b m
val fail : failure -> 'a m
val fail_with_trace : (Trace.t -> failure) -> 'a m
val run : Context.t -> 'a m -> ('a, TypeErrors.t) Result.t

(* val get: unit -> Context.t m *)
val print_with_ctxt : (Context.t -> unit) -> unit m
val get_global : unit -> Global.t m
val all_constraints : unit -> Context.LCSet.t m
val simp_ctxt : unit -> Simplify.simp_ctxt m
val all_resources : unit -> Resources.t list m
val all_resources_tagged : unit -> ((Resources.t * int) list * int) m
val provable : Locations.t -> (LogicalConstraints.t -> [> `True | `False]) m
val model : unit -> (Solver.model_with_q) m
val model_with : Locations.t -> IndexTerms.t -> (Solver.model_with_q option) m
val prev_models_with : Locations.t -> IndexTerms.t -> (Solver.model_with_q list) m
val bound_a : Sym.t -> (bool) m
val bound_l : Sym.t -> (bool) m
val bound : Sym.t -> (bool) m
val get_a : Sym.t -> Context.basetype_or_value m
val get_l : Sym.t -> Context.basetype_or_value m
val remove_a : Sym.t -> (unit) m
val remove_as : Sym.t list -> (unit) m
val add_a : Sym.t -> BaseTypes.t -> Context.l_info -> (unit) m
val add_a_value : Sym.t -> IndexTerms.t -> Context.l_info -> unit m
val add_l : Sym.t -> BaseTypes.t -> Context.l_info -> (unit) m
val add_l_value : Sym.t -> IndexTerms.t -> Context.l_info -> unit m
val add_ls : (Sym.t * BaseTypes.t * Context.l_info) list -> (unit) m
val add_c : LogicalConstraints.t -> (unit) m
val add_cs : LogicalConstraints.t list -> (unit) m
val add_r : Locations.t -> Resources.t -> unit m
val add_rs : Locations.t -> Resources.t list -> unit m
val get_loc_trace : unit -> (Locations.loc list) m
val add_loc_trace : Locations.t -> (unit) m
val get_step_trace : unit -> (Trace.t) m

val res_history : int -> (Context.resource_history) m

val begin_trace_of_step : Trace.opt_pat -> 'a Mucore.mu_expr -> (unit -> (unit) m) m
val begin_trace_of_pure_step : Trace.opt_pat -> 'a Mucore.mu_pexpr -> (unit -> (unit) m) m

type changed = 
  | Deleted
  | Unchanged
  | Unfolded of Resources.t list
  | Changed of Resources.t
  | Read

val map_and_fold_resources : 
  Locations.t ->
  (Resources.t -> 'acc -> changed * 'acc) -> 
  'acc -> 'acc m

val get_struct_decl : Locations.t -> Sym.t -> (Memory.struct_decl) m
val get_struct_member_type : Locations.t -> Sym.t -> Id.t -> (Sctypes.t) m
val get_member_type : Locations.t -> Sym.t -> Id.t -> Memory.struct_layout -> (Sctypes.t) m
val get_datatype : Locations.t -> Sym.t -> (BaseTypes.datatype_info) m
val get_datatype_constr : Locations.t -> Sym.t -> (BaseTypes.constr_info) m
val get_fun_decl : Locations.t -> Sym.t ->
    (Locations.t * Global.AT.ft * Sctypes.c_concrete_sig) m
val get_lemma : Locations.t -> Sym.t -> (Locations.t * Global.AT.lemmat) m

val get_resource_predicate_def : Locations.t -> Sym.t ->
    (ResourcePredicates.definition) m
val get_logical_function_def : Locations.t -> Sym.t ->
    (LogicalFunctions.definition) m


val add_struct_decl : Sym.t -> Memory.struct_layout -> (unit) m
val add_fun_decl : Sym.t -> (Locations.t * ArgumentTypes.ft * Sctypes.c_concrete_sig) ->
    (unit) m
val add_lemma : Sym.t -> (Locations.t * ArgumentTypes.lemmat) -> (unit) m
val add_resource_predicate : Sym.t -> ResourcePredicates.definition -> (unit) m
val add_logical_function : Sym.t -> LogicalFunctions.definition -> (unit) m
val add_datatype : Sym.t -> BaseTypes.datatype_info -> (unit) m
val add_datatype_constr : Sym.t -> BaseTypes.constr_info -> (unit) m


val set_statement_locs : Locations.loc CStatements.LocMap.t -> (unit) m

val value_eq_group : IndexTerms.t option -> IndexTerms.t -> (EqTable.ITSet.t) m
val test_value_eqs : Locations.t -> IndexTerms.t option -> IndexTerms.t ->
    IndexTerms.t list -> (unit) m

val get_loc_addrs_in_eqs : unit -> (Sym.t list) m

val embed_resultat : 'a Resultat.t -> 'a m
