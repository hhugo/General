#include "../Generated/Facets/PredSucc.ml"

module PredSucc = struct
  include PredSucc_.MakeMakers(struct
    let pred ~one ~add:_ ~subtract x = subtract x one
    let succ ~one ~add ~subtract:_ x = add x one
  end)
end

module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  module MakeTests(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing
    open M

    let tests = (
      E.successions
      |> List.flat_map ~f:(fun (p, s) ->
        let rp = repr p and rs = repr s in
        [
          ~: "succ %s" rp (lazy (check ~repr ~equal ~expected:s (succ p)));
          ~: "pred %s" rs (lazy (check ~repr ~equal ~expected:p (pred s)));
        ]
      )
    )
  end

  include MakeMakers(MakeTests)
end
