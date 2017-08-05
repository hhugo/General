module Operators = struct
  module type S0 = sig
    type t

    include Traits.Equatable.Operators.S0 with type t := t
    include Traits.Ringoid.Operators.S0 with type t := t
  end
end

module type S0 = sig
  type t

  module O: Operators.S0 with type t := t

  include Traits.Displayable.S0 with type t := t
  include Traits.Equatable.S0 with type t := t and module O := O
  include Traits.Parsable.S0 with type t := t
  include Traits.Representable.S0 with type t := t
  include Traits.Ringoid.S0 with type t := t and module O := O

  (* @todo Traits.OfStandardNumbers? *)
  (* @todo of_int32, of_int64, of_nativeint *)
  val of_int: int -> t
  val of_float: float -> t
end

module Tests = struct
  open Testing

  module Examples = struct
    module type S0 = sig
      type t

      include Traits.Displayable.Tests.Examples.S0 with type t := t
      include Traits.Equatable.Tests.Examples.S0 with type t := t
      include Traits.Parsable.Tests.Examples.S0 with type t := t
      include Traits.Representable.Tests.Examples.S0 with type t := t
      include Traits.Ringoid.Tests.Examples.S0 with type t := t
    end
  end

  module Make0(M: S0)(E: Examples.S0 with type t := M.t): sig val test: Test.t end = struct
    open M

    module E = struct
      include E

      let equal = equal @ [
        [zero; of_int 0; of_float 0.; M.of_string "0"];
        [one; of_int 1; of_float 1.; M.of_string "1"];
      ]

      let different = different @ [
        (zero, one);
      ]
    end

    let test = "Number" >:: [
      (let module T = Traits.Displayable.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Equatable.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Parsable.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Representable.Tests.Make0(M)(E) in T.test);
      (let module T = Traits.Ringoid.Tests.Make0(M)(E) in T.test);
    ]
  end
end
