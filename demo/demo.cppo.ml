let g = ref 0

module WithoutGeneral = struct
  let _ = "a".[0]
  let _ = [|0|].(0)
end

module WithGeneralStandard = struct
  open General.Standard

  let _ = Reference.contents g
  let _ = OCamlStandard.Arg.Clear (ref true)
  let _ = "a".[0]
  let _ = [|0|].(0)
end

module WithGeneralAbbr = struct
  open General.Abbr

  let _ = Ref.contents g
  let _ = OCamlStandard.Arg.Clear (ref true)
  let _ = "a".[0]
  let _ = [|0|].(0)
end

open General.Abbr

module DemoInteger(N: sig val name: string end)(I: General.Facets.Integer.S0) = struct
  (* Define unusable operators to demonstrate that O actually defines the operators we use. *)
  let (=) = ()
  let (+) = ()
  let (-) = ()

  open I

  let print s v =
    StdOut.print "%s.(%s): %s\n" N.name s v

  let print_int s v =
    print s (repr v)

  let print_bool s v =
    print s (Bo.repr v)

  #define TEST(type, value) let () = CONCAT(print_, type) STRINGIFY(value) value

  TEST(int, zero)
  TEST(int, one)
  TEST(int, O.(one + one))
  TEST(int, O.(one - one))
  TEST(bool, O.(one = one))
  TEST(bool, O.(zero = one))
end

let () = StdOut.print "General.Int.succ 4: %n\n" (General.Int.succ 4)

module DemoGeneralInt = DemoInteger(struct let name = "General.Int" end)(General.Int)

module IntMod3 = struct
  module SelfA = struct
    type t = int
    let zero = 0
    let one = 1
    let of_int x = x mod 3
    let to_int x = x
    let repr = Int.repr
    let of_float x = (Int.of_float x) mod 3
    let to_float = Int.to_float
    let of_string x = (Int.of_string x) mod 3
    let try_of_string s =
      Exn.or_none (lazy (of_string s))
    let to_string = Int.to_string
    let abs x = x
    let add x y = (x + y) mod 3
    let negate x = (6 - x) mod 3
    let multiply x y = (x * y) mod 3
    let divide x y = (x / y + 6) mod 3
    let modulo x y = (x mod y)
    let exponentiate_negative_exponent ~exponentiate:_ _ n =
      Exn.invalid_argument "IntMod3.exponentiate: Negative exponent: %i" n
  end

  module SelfB = struct
    include General.Facets.RingoidBasic.Subtract.Make0(SelfA)
    include General.Facets.Ringoid.Square.Make0(SelfA)
    include SelfA
  end

  module SelfC = struct
    include General.Facets.Ringoid.Exponentiate.Make0(SelfB)
    include General.Facets.PredSucc.PredSucc.Make0(SelfB)
    include SelfB
  end

  module O = struct
    include General.Compare.Poly.O
    include General.Equate.Poly.O
    include General.Facets.Ringoid.Operators.Make0(SelfC)

    let (mod) x y = (x mod y)
  end

  include (General.Compare.Poly: module type of General.Compare.Poly with module O := O)
  include (General.Equate.Poly: module type of General.Equate.Poly with module O := O)
  include SelfC
end

module DemoIntMod3 = DemoInteger(struct let name = "IntMod3" end)(IntMod3)

module IntMod3Examples = struct
  open IntMod3

  let equalities = [
    [of_int 0; of_int 3];
  ]

  let orders = []

  let differences = []

  let representations = []

  let displays = []

  let literals = []

  let additions = [
    (1, 2, 0);
    (2, 2, 1);
  ]

  let negations = [
    (0, 0);
    (1, 2);
  ]

  let multiplications = [
    (2, 2, 1);
  ]

  let divisions = [
    (2, 1, 2);
    (2, 2, 1);
    (1, 2, 0);
  ]

  let exponentiations = [
    (2, 2, 1);
    (2, 3, 2);
    (2, 4, 1);
  ]

  let successions = [
    (0, 1);
    (1, 2);
    (2, 0);
  ]
end

let () = Tst.(
  let test =
    ~:: "de%s" "mo" [
      (let module T = General.Facets.Comparable.Tests.Make0(IntMod3)(IntMod3Examples) in T.test);
      (let module T = General.Facets.Equatable.Tests.Make0(IntMod3)(IntMod3Examples) in T.test);
      (let module T = General.Facets.Representable.Tests.Make0(IntMod3)(IntMod3Examples) in T.test);
      (let module T = General.Facets.Ringoid.Tests.Make0(IntMod3)(IntMod3Examples) in T.test);
      (let module T = General.Facets.Number.Tests.Make0(IntMod3)(IntMod3Examples) in T.test);
      (let module T = General.Facets.RealNumber.Tests.Make0(IntMod3)(IntMod3Examples) in T.test);
      (* Integer.Tests includes all tests above. The previous lines are only here to prove that we export the functors. *)
      (let module T = General.Facets.Integer.Tests.Make0(IntMod3)(IntMod3Examples) in T.test);
      ~: "some %s" "test" (lazy ());
    ]
  in
  Exit.exit (command_line_main ~argv:(Li.of_array OCamlStandard.Sys.argv) test)
)
