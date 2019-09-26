module type S0 = sig
  include Basic.S0

  val reduce_short: t -> f:(elt -> elt -> Shorten.t * elt) -> elt
  val reduce_short_i: t -> f:(i:int -> elt -> elt -> Shorten.t * elt) -> elt
  val reduce_short_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * Shorten.t * elt) -> elt

  val try_reduce_short: t -> f:(elt -> elt -> Shorten.t * elt) -> (elt) option
  val try_reduce_short_i: t -> f:(i:int -> elt -> elt -> Shorten.t * elt) -> (elt) option
  val try_reduce_short_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> elt -> 'acc * Shorten.t * elt) -> (elt) option

  val iter_short: t -> f:(elt -> Shorten.t) -> unit
  val iter_short_i: t -> f:(i:int -> elt -> Shorten.t) -> unit
  val iter_short_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * Shorten.t) -> unit

  val for_all: t -> f:(elt -> bool) -> bool
  val for_all_i: t -> f:(i:int -> elt -> bool) -> bool
  val for_all_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> bool

  val there_exists: t -> f:(elt -> bool) -> bool
  val there_exists_i: t -> f:(i:int -> elt -> bool) -> bool
  val there_exists_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> bool

  val find: t -> f:(elt -> bool) -> elt
  val find_i: t -> f:(i:int -> elt -> bool) -> elt
  val find_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> elt

  val try_find: t -> f:(elt -> bool) -> (elt) option
  val try_find_i: t -> f:(i:int -> elt -> bool) -> (elt) option
  val try_find_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * bool) -> (elt) option

  (* @feature contains = try_find |> is_some (also = there_exists f:(equal x)) *)

  val find_map: t -> f:(elt -> 'b option) -> 'b
  val find_map_i: t -> f:(i:int -> elt -> 'b option) -> 'b
  val find_map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * 'b option) -> 'b

  val try_find_map: t -> f:(elt -> 'b option) -> ( 'b) option
  val try_find_map_i: t -> f:(i:int -> elt -> 'b option) -> ( 'b) option
  val try_find_map_acc: acc:'acc -> t -> f:(acc:'acc -> elt -> 'acc * 'b option) -> ( 'b) option
end

module type S1 = sig
  include Basic.S1

  val reduce_short: 'a t -> f:('a -> 'a -> Shorten.t * 'a) -> 'a
  val reduce_short_i: 'a t -> f:(i:int -> 'a -> 'a -> Shorten.t * 'a) -> 'a
  val reduce_short_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * Shorten.t * 'a) -> 'a

  val try_reduce_short: 'a t -> f:('a -> 'a -> Shorten.t * 'a) -> ('a) option
  val try_reduce_short_i: 'a t -> f:(i:int -> 'a -> 'a -> Shorten.t * 'a) -> ('a) option
  val try_reduce_short_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'a -> 'acc * Shorten.t * 'a) -> ('a) option

  val iter_short: 'a t -> f:('a -> Shorten.t) -> unit
  val iter_short_i: 'a t -> f:(i:int -> 'a -> Shorten.t) -> unit
  val iter_short_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * Shorten.t) -> unit

  val for_all: 'a t -> f:('a -> bool) -> bool
  val for_all_i: 'a t -> f:(i:int -> 'a -> bool) -> bool
  val for_all_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> bool

  val there_exists: 'a t -> f:('a -> bool) -> bool
  val there_exists_i: 'a t -> f:(i:int -> 'a -> bool) -> bool
  val there_exists_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> bool

  val find: 'a t -> f:('a -> bool) -> 'a
  val find_i: 'a t -> f:(i:int -> 'a -> bool) -> 'a
  val find_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> 'a

  val try_find: 'a t -> f:('a -> bool) -> ('a) option
  val try_find_i: 'a t -> f:(i:int -> 'a -> bool) -> ('a) option
  val try_find_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * bool) -> ('a) option

  val find_map: 'a t -> f:('a -> 'b option) -> 'b
  val find_map_i: 'a t -> f:(i:int -> 'a -> 'b option) -> 'b
  val find_map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b option) -> 'b

  val try_find_map: 'a t -> f:('a -> 'b option) -> ( 'b) option
  val try_find_map_i: 'a t -> f:(i:int -> 'a -> 'b option) -> ( 'b) option
  val try_find_map_acc: acc:'acc -> 'a t -> f:(acc:'acc -> 'a -> 'acc * 'b option) -> ( 'b) option
end
