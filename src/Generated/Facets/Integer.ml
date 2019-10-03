module Operators = struct
  module type S0 = sig
    type t
    include RealNumber.Operators.S0 with type t := t
  end
end

module type S0 = sig
  type t
  module O: Operators.S0 with type t := t
  include RealNumber.S0 with type t := t and module O := O
  include PredSucc.S0 with type t := t
end

module Tests_alpha(Testing: Testing) = struct
  module Examples = struct
    module type S0 = sig
      type t
      include RealNumber.Tests_beta(Testing).Examples.S0 with type t := t
      include PredSucc.Tests_beta(Testing).Examples.S0 with type t := t
    end
  end

  module Testable = struct
    module type S0 = sig
      include S0
    end
  end

  module MakeMakers(MakeTests: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> sig val tests: Test.t list end) = struct
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      open Testing
      let test = "Integer" >:: [
        (let module T_alpha = RealNumber.Tests_beta(Testing) in let module T = T_alpha.Make0(M)(E) in T.test);
        (let module T_alpha = PredSucc.Tests_beta(Testing) in let module T = T_alpha.Make0(M)(E) in T.test);
      ] @ (let module T = MakeTests(M)(E) in T.tests)
    end
  end
end