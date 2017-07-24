module Basic = struct
  module type S0 = sig
    type t

    val zero: t
    val one: t

    val negate: t -> t
    val add: t -> t -> t
    val substract: t -> t -> t
    val multiply: t -> t -> t
    val divide: t -> t -> t
  end
end

module Operators = struct
  module type S0 = sig
    type t

    val (~-): t -> t
    val (+): t -> t -> t
    val (-): t -> t -> t
    val ( * ): t -> t -> t
    val (/): t -> t -> t
  end
end

module type S0 = sig
  include Basic.S0

  val square: t -> t
  (* @todo val exponentiate: t -> int -> t *)

  module O: Operators.S0 with type t := t
end

module Make0(B: Basic.S0) = struct
  include B

  let square x =
    multiply x x

  module O = struct
    let (~-) x =
      negate x

    let (+) x y =
      add x y

    let (-) x y =
      substract x y

    let ( * ) x y =
      multiply x y

    let (/) x y =
      divide x y
  end
end

module Examples = struct
  module type S0 = sig
    type t

    val add_substract: (t * t * t) list
    val negate: (t * t) list
    val multiply: (t * t * t) list
    val divide: (t * t * t) list
  end
end
