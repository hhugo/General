open Foundations

module Operators = struct
  module type S0 = sig
    type t

    include Number.Operators.S0 with type t := t
    include Traits.Comparable.Operators.S0 with type t := t

    val (mod): t -> t -> t
  end
end

module type S0 = sig
  type t

  module O: Operators.S0 with type t := t

  include Number.S0 with type t := t and module O := O
  include Traits.Comparable.S0 with type t := t and module O := O
  (* @todo Parsable *)

  val abs: t -> t
  val modulo: t -> t -> t

  (* @todo Traits.ToStandardNumbers? *)
  val to_int: t -> int
  val to_float: t -> float

  (* @todo sign *)
end

module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      include Number.Tests.Examples.S0 with type t := t
      include Traits.Comparable.Tests.Examples.S0 with type t := t
    end
  end

  module Make0(M: S0)(E: Examples.S0 with type t := M.t): sig val test: Test.t end = struct
    open M

    module E = struct
      include E

      let ordered = ordered @ [
        [zero; one];
      ]
    end

    let check = check ~repr ~equal

    let test = "RealNumber" >:: [
      (let module T = Number.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Comparable.Tests.Make0(M)(E) in T.test);
    ] @ (
      E.negate
      |> List_.concat_map ~f:(fun (x, y) ->
        let abs_x = if greater_or_equal x zero then x else y
        and abs_y = if greater_or_equal y zero then y else x in
        [
          ~: "abs %s" (repr x) (lazy (check ~expected:abs_x (abs x)));
          ~: "abs %s" (repr y) (lazy (check ~expected:abs_y (abs y)));
        ]
      )
    ) @ [
      "to_int zero" >: (lazy (check_int ~expected:0 (to_int zero)));
      "to_float zero" >: (lazy (check_float_exact ~expected:0. (to_float zero)));
      "to_int one" >: (lazy (check_int ~expected:1 (to_int one)));
      "to_float one" >: (lazy (check_float_exact ~expected:1. (to_float one)));
    ]
  end
end
