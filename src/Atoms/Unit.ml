module Basic = struct
  type t = unit

  let ignore = OCamlStandard.Pervasives.ignore

  module O = struct
    include Compare.Poly.O
    include Equate.Poly.O
  end

  include (Compare.Poly: module type of Compare.Poly with module O := O)
  include (Equate.Poly: module type of Equate.Poly with module O := O)

  let repr () = "()"
end

module Extended(Facets: Facets) = struct
  include Basic

  #ifdef TESTING_GENERAL
  module MakeTests(Standard: Standard) = struct
    open Standard

    #include "../Generated/Atoms/Unit.ml"

    include Tests_.Make(Basic)(struct
      let values = [()]

      let representations = [
        ((), "()");
      ]

      let equalities = []

      let differences = []

      let strict_orders = []

      let order_classes = []
    end)(struct
      let tests = []
    end)
  end
  #endif
end
