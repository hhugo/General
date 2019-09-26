#include "../Generated/Facets/Integer.ml"

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  (*
  module MakeExamples(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    include E

    let successions = successions @ [
      (M.zero, M.one);
    ]
  end
  *)

  module MakeTests(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    let tests = []
  end

  include MakeMakers(MakeTests)
end
