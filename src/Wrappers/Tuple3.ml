#include "../Generated/Wrappers/Tuple3.ml"

module Basic = struct
  type ('a, 'b, 'c) t = 'a * 'b * 'c

  let make x y z =
    (x, y, z)

  let get_0 (x, _, _) =
    x

  let get_1 (_, y, _) =
    y

  let get_2 (_, _, z) =
    z

  let flip (x, y, z) =
    (z, y, x)

  let compare (x, y, z) (x', y', z') ~compare_a ~compare_b ~compare_c =
    Compare.(match compare_a x x' with
      | LT -> LT
      | GT -> GT
      | EQ -> (match compare_b y y' with
        | LT -> LT
        | GT -> GT
        | EQ -> compare_c z z'
      )
    )

  let equal (x, y, z) (x', y', z') ~equal_a ~equal_b ~equal_c =
    Bool.O.(equal_a x x' && equal_b y y' && equal_c z z')

  let repr (x, y, z) ~repr_a ~repr_b ~repr_c =
    Format.apply "(%s, %s, %s)" (repr_a x) (repr_b y) (repr_c z)
end

module Extended(Facets: Facets) = struct
  module SelfA = Basic

  module SelfB = struct
    include SelfA
    include Facets.Comparable.GreaterLessThan.Make3(SelfA)
    include Facets.Comparable.MinMax.Make3(SelfA)
    include Facets.Equatable.Different.Make3(SelfA)
  end

  module Self = struct
    include SelfB
    include Facets.Comparable.Between.Make3(SelfB)
  end

  include Self
end

(*
module Tests = Tests_.Make(Self)(struct
  module A = Foundations.Int
  module B = Foundations.String
  module C = Foundations.Float

  let representations = [
    ((1, "a", 2.), "(1, \"a\", 2.)");
  ]

  let equalities = [
    [(1, "a", 2.)];
  ]

  let differences = [
    ((1, "a", 2.), (1, "a", 3.));
    ((1, "a", 2.), (1, "b", 2.));
    ((1, "a", 2.), (2, "a", 2.));
  ]

  let orders = [
    [(0, "a", 0.); (0, "a", 1.); (0, "b", 0.); (1, "a", 0.)]
  ]
end)(struct
  open Testing

  let tests = [
    "make" >: (lazy (check_int_tuple3 ~expected:(1, 2, 3) (make 1 2 3)));
    "flip" >: (lazy (check_int_tuple3 ~expected:(1, 2, 3) (flip (3, 2, 1))));
    "get_0" >: (lazy (check_42 (get_0 (42, 0, 0))));
    "get_1" >: (lazy (check_42 (get_1 (0, 42, 0))));
    "get_2" >: (lazy (check_42 (get_2 (0, 0, 42))));
  ]
end)
*)
