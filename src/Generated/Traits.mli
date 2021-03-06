module Representable: sig
  module type S0 = sig
    type t
    val repr: t -> string
  end

  module type S1 = sig
    type 'a t
    val repr: 'a t -> repr_a:('a -> string) -> string
  end

  module type S2 = sig
    type ('a, 'b) t
    val repr: ('a, 'b) t -> repr_a:('a -> string) -> repr_b:('b -> string) -> string
  end

  module type S3 = sig
    type ('a, 'b, 'c) t
    val repr: ('a, 'b, 'c) t -> repr_a:('a -> string) -> repr_b:('b -> string) -> repr_c:('c -> string) -> string
  end

  module type S4 = sig
    type ('a, 'b, 'c, 'd) t
    val repr: ('a, 'b, 'c, 'd) t -> repr_a:('a -> string) -> repr_b:('b -> string) -> repr_c:('c -> string) -> repr_d:('d -> string) -> string
  end

  module type S5 = sig
    type ('a, 'b, 'c, 'd, 'e) t
    val repr: ('a, 'b, 'c, 'd, 'e) t -> repr_a:('a -> string) -> repr_b:('b -> string) -> repr_c:('c -> string) -> repr_d:('d -> string) -> repr_e:('e -> string) -> string
  end

  module Specialize1(M: S1)(A: S0): sig
    type t = A.t M.t
    include S0 with type t := t
  end

  module Specialize2(M: S2)(A: S0)(B: S0): sig
    type t = (A.t, B.t) M.t
    include S0 with type t := t
  end

  module Specialize3(M: S3)(A: S0)(B: S0)(C: S0): sig
    type t = (A.t, B.t, C.t) M.t
    include S0 with type t := t
  end

  module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0): sig
    type t = (A.t, B.t, C.t, D.t) M.t
    include S0 with type t := t
  end

  module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0): sig
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    include S0 with type t := t
  end

  module Tests: sig
    module Examples: sig
      module type Element = sig
        type t
        include S0 with type t := t
      end

      module type S0 = sig
        type t
        val representations: (t * string) list
      end

      module type S1 = sig
        type 'a t
        module A: Element
        val representations: (A.t t * string) list
      end

      module type S2 = sig
        type ('a, 'b) t
        module A: Element
        module B: Element
        val representations: ((A.t, B.t) t * string) list
      end

      module type S3 = sig
        type ('a, 'b, 'c) t
        module A: Element
        module B: Element
        module C: Element
        val representations: ((A.t, B.t, C.t) t * string) list
      end

      module type S4 = sig
        type ('a, 'b, 'c, 'd) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        val representations: ((A.t, B.t, C.t, D.t) t * string) list
      end

      module type S5 = sig
        type ('a, 'b, 'c, 'd, 'e) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        module E: Element
        val representations: ((A.t, B.t, C.t, D.t, E.t) t * string) list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
      end

      module type S1 = sig
        include S1
      end

      module type S2 = sig
        include S2
      end

      module type S3 = sig
        include S3
      end

      module type S4 = sig
        include S4
      end

      module type S5 = sig
        include S5
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end

    module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t): sig
      val test: Test.t
    end

    module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t): sig
      val test: Test.t
    end

    module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t): sig
      val test: Test.t
    end

    module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t): sig
      val test: Test.t
    end

    module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t): sig
      val test: Test.t
    end
  end
end

module Equatable: sig
  module Operators: sig
    module type S0 = sig
      type t
      val ( = ): t -> t -> bool
      val ( <> ): t -> t -> bool
    end

    module Make0(M: sig
      type t
      val equal: t -> t -> bool
      val different: t -> t -> bool
    end): sig
      val ( = ): M.t -> M.t -> bool
      val ( <> ): M.t -> M.t -> bool
    end
  end

  module Basic: sig
    module type S0 = sig
      type t
      val equal: t -> t -> bool
    end

    module type S1 = sig
      type 'a t
      val equal: 'a t -> 'a t -> equal_a:('a -> 'a -> bool) -> bool
    end

    module type S2 = sig
      type ('a, 'b) t
      val equal: ('a, 'b) t -> ('a, 'b) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> bool
    end

    module type S3 = sig
      type ('a, 'b, 'c) t
      val equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> bool
    end

    module type S4 = sig
      type ('a, 'b, 'c, 'd) t
      val equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> bool
    end

    module type S5 = sig
      type ('a, 'b, 'c, 'd, 'e) t
      val equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> equal_e:('e -> 'e -> bool) -> bool
    end

    module Specialize1(M: S1)(A: S0): sig
      type t = A.t M.t
      include S0 with type t := t
    end

    module Specialize2(M: S2)(A: S0)(B: S0): sig
      type t = (A.t, B.t) M.t
      include S0 with type t := t
    end

    module Specialize3(M: S3)(A: S0)(B: S0)(C: S0): sig
      type t = (A.t, B.t, C.t) M.t
      include S0 with type t := t
    end

    module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0): sig
      type t = (A.t, B.t, C.t, D.t) M.t
      include S0 with type t := t
    end

    module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0): sig
      type t = (A.t, B.t, C.t, D.t, E.t) M.t
      include S0 with type t := t
    end
  end

  module type S0 = sig
    include Basic.S0
    module O: Operators.S0 with type t := t
    val different: t -> t -> bool
  end

  module type S1 = sig
    include Basic.S1
    val different: 'a t -> 'a t -> equal_a:('a -> 'a -> bool) -> bool
  end

  module type S2 = sig
    include Basic.S2
    val different: ('a, 'b) t -> ('a, 'b) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> bool
  end

  module type S3 = sig
    include Basic.S3
    val different: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> bool
  end

  module type S4 = sig
    include Basic.S4
    val different: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> bool
  end

  module type S5 = sig
    include Basic.S5
    val different: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> equal_e:('e -> 'e -> bool) -> bool
  end

  module Specialize1(M: S1)(A: Basic.S0): sig
    type t = A.t M.t
    include S0 with type t := t
  end

  module Specialize2(M: S2)(A: Basic.S0)(B: Basic.S0): sig
    type t = (A.t, B.t) M.t
    include S0 with type t := t
  end

  module Specialize3(M: S3)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0): sig
    type t = (A.t, B.t, C.t) M.t
    include S0 with type t := t
  end

  module Specialize4(M: S4)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0)(D: Basic.S0): sig
    type t = (A.t, B.t, C.t, D.t) M.t
    include S0 with type t := t
  end

  module Specialize5(M: S5)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0)(D: Basic.S0)(E: Basic.S0): sig
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    include S0 with type t := t
  end

  module Different: sig
    module Make0(M: sig
      type t
      val equal: t -> t -> bool
    end): sig
      val different: M.t -> M.t -> bool
    end

    module Make1(M: sig
      type 'a t
      val equal: 'a t -> 'a t -> equal_a:('a -> 'a -> bool) -> bool
    end): sig
      val different: 'a M.t -> 'a M.t -> equal_a:('a -> 'a -> bool) -> bool
    end

    module Make2(M: sig
      type ('a, 'b) t
      val equal: ('a, 'b) t -> ('a, 'b) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> bool
    end): sig
      val different: ('a, 'b) M.t -> ('a, 'b) M.t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> bool
    end

    module Make3(M: sig
      type ('a, 'b, 'c) t
      val equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> bool
    end): sig
      val different: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> bool
    end

    module Make4(M: sig
      type ('a, 'b, 'c, 'd) t
      val equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> bool
    end): sig
      val different: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> bool
    end

    module Make5(M: sig
      type ('a, 'b, 'c, 'd, 'e) t
      val equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> equal_e:('e -> 'e -> bool) -> bool
    end): sig
      val different: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> equal_a:('a -> 'a -> bool) -> equal_b:('b -> 'b -> bool) -> equal_c:('c -> 'c -> bool) -> equal_d:('d -> 'd -> bool) -> equal_e:('e -> 'e -> bool) -> bool
    end
  end

  module Tests: sig
    module Examples: sig
      module type Element = sig
        type t
        include Basic.S0 with type t := t
        include Representable.S0 with type t := t
      end

      module type S0 = sig
        type t
        val equalities: t list list
        val differences: (t * t) list
      end

      module type S1 = sig
        type 'a t
        module A: Element
        val equalities: A.t t list list
        val differences: (A.t t * A.t t) list
      end

      module type S2 = sig
        type ('a, 'b) t
        module A: Element
        module B: Element
        val equalities: (A.t, B.t) t list list
        val differences: ((A.t, B.t) t * (A.t, B.t) t) list
      end

      module type S3 = sig
        type ('a, 'b, 'c) t
        module A: Element
        module B: Element
        module C: Element
        val equalities: (A.t, B.t, C.t) t list list
        val differences: ((A.t, B.t, C.t) t * (A.t, B.t, C.t) t) list
      end

      module type S4 = sig
        type ('a, 'b, 'c, 'd) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        val equalities: (A.t, B.t, C.t, D.t) t list list
        val differences: ((A.t, B.t, C.t, D.t) t * (A.t, B.t, C.t, D.t) t) list
      end

      module type S5 = sig
        type ('a, 'b, 'c, 'd, 'e) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        module E: Element
        val equalities: (A.t, B.t, C.t, D.t, E.t) t list list
        val differences: ((A.t, B.t, C.t, D.t, E.t) t * (A.t, B.t, C.t, D.t, E.t) t) list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include Representable.S0 with type t := t
      end

      module type S1 = sig
        include S1
        include Representable.S1 with type 'a t := 'a t
      end

      module type S2 = sig
        include S2
        include Representable.S2 with type ('a, 'b) t := ('a, 'b) t
      end

      module type S3 = sig
        include S3
        include Representable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
      end

      module type S4 = sig
        include S4
        include Representable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
      end

      module type S5 = sig
        include S5
        include Representable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end

    module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t): sig
      val test: Test.t
    end

    module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t): sig
      val test: Test.t
    end

    module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t): sig
      val test: Test.t
    end

    module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t): sig
      val test: Test.t
    end

    module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t): sig
      val test: Test.t
    end
  end
end

module Displayable: sig
  module type S0 = sig
    type t
    val to_string: t -> string
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        val displays: (t * string) list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module Parsable: sig
  module type S0 = sig
    type t
    val try_of_string: string -> t option
    val of_string: string -> t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        val literals: (string * t) list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include Equatable.Basic.S0 with type t := t
        include Representable.S0 with type t := t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module Comparable: sig
  module Operators: sig
    module type S0 = sig
      type t
      val ( < ): t -> t -> bool
      val ( <= ): t -> t -> bool
      val ( > ): t -> t -> bool
      val ( >= ): t -> t -> bool
    end

    module Make0(M: sig
      type t
      val less_than: t -> t -> bool
      val less_or_equal: t -> t -> bool
      val greater_than: t -> t -> bool
      val greater_or_equal: t -> t -> bool
    end): sig
      val ( < ): M.t -> M.t -> bool
      val ( <= ): M.t -> M.t -> bool
      val ( > ): M.t -> M.t -> bool
      val ( >= ): M.t -> M.t -> bool
    end
  end

  module Basic: sig
    module type S0 = sig
      type t
      val compare: t -> t -> Compare.t
    end

    module type S1 = sig
      type 'a t
      val compare: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> Compare.t
    end

    module type S2 = sig
      type ('a, 'b) t
      val compare: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> Compare.t
    end

    module type S3 = sig
      type ('a, 'b, 'c) t
      val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> Compare.t
    end

    module type S4 = sig
      type ('a, 'b, 'c, 'd) t
      val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> Compare.t
    end

    module type S5 = sig
      type ('a, 'b, 'c, 'd, 'e) t
      val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> Compare.t
    end

    module Specialize1(M: S1)(A: S0): sig
      type t = A.t M.t
      include S0 with type t := t
    end

    module Specialize2(M: S2)(A: S0)(B: S0): sig
      type t = (A.t, B.t) M.t
      include S0 with type t := t
    end

    module Specialize3(M: S3)(A: S0)(B: S0)(C: S0): sig
      type t = (A.t, B.t, C.t) M.t
      include S0 with type t := t
    end

    module Specialize4(M: S4)(A: S0)(B: S0)(C: S0)(D: S0): sig
      type t = (A.t, B.t, C.t, D.t) M.t
      include S0 with type t := t
    end

    module Specialize5(M: S5)(A: S0)(B: S0)(C: S0)(D: S0)(E: S0): sig
      type t = (A.t, B.t, C.t, D.t, E.t) M.t
      include S0 with type t := t
    end
  end

  module type S0 = sig
    include Basic.S0
    module O: Operators.S0 with type t := t
    val less_than: t -> t -> bool
    val less_or_equal: t -> t -> bool
    val greater_than: t -> t -> bool
    val greater_or_equal: t -> t -> bool
    val between: t -> low:(t) -> high:(t) -> bool
    val between_or_equal: t -> low:(t) -> high:(t) -> bool
    val min: t -> t -> t
    val max: t -> t -> t
    val min_max: t -> t -> t * t
  end

  module type S1 = sig
    include Basic.S1
    val less_than: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
    val less_or_equal: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
    val greater_than: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
    val greater_or_equal: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
    val between: 'a t -> low:('a t) -> high:('a t) -> compare_a:('a -> 'a -> Compare.t) -> bool
    val between_or_equal: 'a t -> low:('a t) -> high:('a t) -> compare_a:('a -> 'a -> Compare.t) -> bool
    val min: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> 'a t
    val max: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> 'a t
    val min_max: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> 'a t * 'a t
  end

  module type S2 = sig
    include Basic.S2
    val less_than: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    val less_or_equal: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    val greater_than: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    val greater_or_equal: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    val between: ('a, 'b) t -> low:(('a, 'b) t) -> high:(('a, 'b) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    val between_or_equal: ('a, 'b) t -> low:(('a, 'b) t) -> high:(('a, 'b) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    val min: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> ('a, 'b) t
    val max: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> ('a, 'b) t
    val min_max: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> ('a, 'b) t * ('a, 'b) t
  end

  module type S3 = sig
    include Basic.S3
    val less_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    val less_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    val greater_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    val greater_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    val between: ('a, 'b, 'c) t -> low:(('a, 'b, 'c) t) -> high:(('a, 'b, 'c) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    val between_or_equal: ('a, 'b, 'c) t -> low:(('a, 'b, 'c) t) -> high:(('a, 'b, 'c) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    val min: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> ('a, 'b, 'c) t
    val max: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> ('a, 'b, 'c) t
    val min_max: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> ('a, 'b, 'c) t * ('a, 'b, 'c) t
  end

  module type S4 = sig
    include Basic.S4
    val less_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    val less_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    val greater_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    val greater_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    val between: ('a, 'b, 'c, 'd) t -> low:(('a, 'b, 'c, 'd) t) -> high:(('a, 'b, 'c, 'd) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    val between_or_equal: ('a, 'b, 'c, 'd) t -> low:(('a, 'b, 'c, 'd) t) -> high:(('a, 'b, 'c, 'd) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    val min: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> ('a, 'b, 'c, 'd) t
    val max: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> ('a, 'b, 'c, 'd) t
    val min_max: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> ('a, 'b, 'c, 'd) t * ('a, 'b, 'c, 'd) t
  end

  module type S5 = sig
    include Basic.S5
    val less_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    val less_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    val greater_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    val greater_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    val between: ('a, 'b, 'c, 'd, 'e) t -> low:(('a, 'b, 'c, 'd, 'e) t) -> high:(('a, 'b, 'c, 'd, 'e) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    val between_or_equal: ('a, 'b, 'c, 'd, 'e) t -> low:(('a, 'b, 'c, 'd, 'e) t) -> high:(('a, 'b, 'c, 'd, 'e) t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    val min: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> ('a, 'b, 'c, 'd, 'e) t
    val max: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> ('a, 'b, 'c, 'd, 'e) t
    val min_max: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> ('a, 'b, 'c, 'd, 'e) t * ('a, 'b, 'c, 'd, 'e) t
  end

  module Specialize1(M: S1)(A: Basic.S0): sig
    type t = A.t M.t
    include S0 with type t := t
  end

  module Specialize2(M: S2)(A: Basic.S0)(B: Basic.S0): sig
    type t = (A.t, B.t) M.t
    include S0 with type t := t
  end

  module Specialize3(M: S3)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0): sig
    type t = (A.t, B.t, C.t) M.t
    include S0 with type t := t
  end

  module Specialize4(M: S4)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0)(D: Basic.S0): sig
    type t = (A.t, B.t, C.t, D.t) M.t
    include S0 with type t := t
  end

  module Specialize5(M: S5)(A: Basic.S0)(B: Basic.S0)(C: Basic.S0)(D: Basic.S0)(E: Basic.S0): sig
    type t = (A.t, B.t, C.t, D.t, E.t) M.t
    include S0 with type t := t
  end

  module GreaterLessThan: sig
    module Make0(M: sig
      type t
      val compare: t -> t -> Compare.t
    end): sig
      val less_than: M.t -> M.t -> bool
      val less_or_equal: M.t -> M.t -> bool
      val greater_than: M.t -> M.t -> bool
      val greater_or_equal: M.t -> M.t -> bool
    end

    module Make1(M: sig
      type 'a t
      val compare: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> Compare.t
    end): sig
      val less_than: 'a M.t -> 'a M.t -> compare_a:('a -> 'a -> Compare.t) -> bool
      val less_or_equal: 'a M.t -> 'a M.t -> compare_a:('a -> 'a -> Compare.t) -> bool
      val greater_than: 'a M.t -> 'a M.t -> compare_a:('a -> 'a -> Compare.t) -> bool
      val greater_or_equal: 'a M.t -> 'a M.t -> compare_a:('a -> 'a -> Compare.t) -> bool
    end

    module Make2(M: sig
      type ('a, 'b) t
      val compare: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> Compare.t
    end): sig
      val less_than: ('a, 'b) M.t -> ('a, 'b) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val less_or_equal: ('a, 'b) M.t -> ('a, 'b) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val greater_than: ('a, 'b) M.t -> ('a, 'b) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b) M.t -> ('a, 'b) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    end

    module Make3(M: sig
      type ('a, 'b, 'c) t
      val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> Compare.t
    end): sig
      val less_than: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val less_or_equal: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val greater_than: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    end

    module Make4(M: sig
      type ('a, 'b, 'c, 'd) t
      val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> Compare.t
    end): sig
      val less_than: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val less_or_equal: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val greater_than: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    end

    module Make5(M: sig
      type ('a, 'b, 'c, 'd, 'e) t
      val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> Compare.t
    end): sig
      val less_than: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val less_or_equal: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val greater_than: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    end
  end

  module Between: sig
    module Make0(M: sig
      type t
      val less_than: t -> t -> bool
      val less_or_equal: t -> t -> bool
      val greater_than: t -> t -> bool
      val greater_or_equal: t -> t -> bool
    end): sig
      val between: M.t -> low:(M.t) -> high:(M.t) -> bool
      val between_or_equal: M.t -> low:(M.t) -> high:(M.t) -> bool
    end

    module Make1(M: sig
      type 'a t
      val less_than: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
      val less_or_equal: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
      val greater_than: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
      val greater_or_equal: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> bool
    end): sig
      val between: 'a M.t -> low:('a M.t) -> high:('a M.t) -> compare_a:('a -> 'a -> Compare.t) -> bool
      val between_or_equal: 'a M.t -> low:('a M.t) -> high:('a M.t) -> compare_a:('a -> 'a -> Compare.t) -> bool
    end

    module Make2(M: sig
      type ('a, 'b) t
      val less_than: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val less_or_equal: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val greater_than: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    end): sig
      val between: ('a, 'b) M.t -> low:(('a, 'b) M.t) -> high:(('a, 'b) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
      val between_or_equal: ('a, 'b) M.t -> low:(('a, 'b) M.t) -> high:(('a, 'b) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> bool
    end

    module Make3(M: sig
      type ('a, 'b, 'c) t
      val less_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val less_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val greater_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    end): sig
      val between: ('a, 'b, 'c) M.t -> low:(('a, 'b, 'c) M.t) -> high:(('a, 'b, 'c) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
      val between_or_equal: ('a, 'b, 'c) M.t -> low:(('a, 'b, 'c) M.t) -> high:(('a, 'b, 'c) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> bool
    end

    module Make4(M: sig
      type ('a, 'b, 'c, 'd) t
      val less_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val less_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val greater_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    end): sig
      val between: ('a, 'b, 'c, 'd) M.t -> low:(('a, 'b, 'c, 'd) M.t) -> high:(('a, 'b, 'c, 'd) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
      val between_or_equal: ('a, 'b, 'c, 'd) M.t -> low:(('a, 'b, 'c, 'd) M.t) -> high:(('a, 'b, 'c, 'd) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> bool
    end

    module Make5(M: sig
      type ('a, 'b, 'c, 'd, 'e) t
      val less_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val less_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val greater_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val greater_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    end): sig
      val between: ('a, 'b, 'c, 'd, 'e) M.t -> low:(('a, 'b, 'c, 'd, 'e) M.t) -> high:(('a, 'b, 'c, 'd, 'e) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
      val between_or_equal: ('a, 'b, 'c, 'd, 'e) M.t -> low:(('a, 'b, 'c, 'd, 'e) M.t) -> high:(('a, 'b, 'c, 'd, 'e) M.t) -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> bool
    end
  end

  module MinMax: sig
    module Make0(M: sig
      type t
      val compare: t -> t -> Compare.t
    end): sig
      val min: M.t -> M.t -> M.t
      val max: M.t -> M.t -> M.t
      val min_max: M.t -> M.t -> M.t * M.t
    end

    module Make1(M: sig
      type 'a t
      val compare: 'a t -> 'a t -> compare_a:('a -> 'a -> Compare.t) -> Compare.t
    end): sig
      val min: 'a M.t -> 'a M.t -> compare_a:('a -> 'a -> Compare.t) -> 'a M.t
      val max: 'a M.t -> 'a M.t -> compare_a:('a -> 'a -> Compare.t) -> 'a M.t
      val min_max: 'a M.t -> 'a M.t -> compare_a:('a -> 'a -> Compare.t) -> 'a M.t * 'a M.t
    end

    module Make2(M: sig
      type ('a, 'b) t
      val compare: ('a, 'b) t -> ('a, 'b) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> Compare.t
    end): sig
      val min: ('a, 'b) M.t -> ('a, 'b) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> ('a, 'b) M.t
      val max: ('a, 'b) M.t -> ('a, 'b) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> ('a, 'b) M.t
      val min_max: ('a, 'b) M.t -> ('a, 'b) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> ('a, 'b) M.t * ('a, 'b) M.t
    end

    module Make3(M: sig
      type ('a, 'b, 'c) t
      val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> Compare.t
    end): sig
      val min: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> ('a, 'b, 'c) M.t
      val max: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> ('a, 'b, 'c) M.t
      val min_max: ('a, 'b, 'c) M.t -> ('a, 'b, 'c) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> ('a, 'b, 'c) M.t * ('a, 'b, 'c) M.t
    end

    module Make4(M: sig
      type ('a, 'b, 'c, 'd) t
      val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> Compare.t
    end): sig
      val min: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> ('a, 'b, 'c, 'd) M.t
      val max: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> ('a, 'b, 'c, 'd) M.t
      val min_max: ('a, 'b, 'c, 'd) M.t -> ('a, 'b, 'c, 'd) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> ('a, 'b, 'c, 'd) M.t * ('a, 'b, 'c, 'd) M.t
    end

    module Make5(M: sig
      type ('a, 'b, 'c, 'd, 'e) t
      val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> Compare.t
    end): sig
      val min: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> ('a, 'b, 'c, 'd, 'e) M.t
      val max: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> ('a, 'b, 'c, 'd, 'e) M.t
      val min_max: ('a, 'b, 'c, 'd, 'e) M.t -> ('a, 'b, 'c, 'd, 'e) M.t -> compare_a:('a -> 'a -> Compare.t) -> compare_b:('b -> 'b -> Compare.t) -> compare_c:('c -> 'c -> Compare.t) -> compare_d:('d -> 'd -> Compare.t) -> compare_e:('e -> 'e -> Compare.t) -> ('a, 'b, 'c, 'd, 'e) M.t * ('a, 'b, 'c, 'd, 'e) M.t
    end
  end

  module Tests: sig
    module Examples: sig
      module type Element = sig
        type t
        include Basic.S0 with type t := t
        include Equatable.Basic.S0 with type t := t
        include Representable.S0 with type t := t
      end

      module type S0 = sig
        type t
        val orders: t list list
        val equalities: t list list
      end

      module type S1 = sig
        type 'a t
        module A: Element
        val orders: A.t t list list
        val equalities: A.t t list list
      end

      module type S2 = sig
        type ('a, 'b) t
        module A: Element
        module B: Element
        val orders: (A.t, B.t) t list list
        val equalities: (A.t, B.t) t list list
      end

      module type S3 = sig
        type ('a, 'b, 'c) t
        module A: Element
        module B: Element
        module C: Element
        val orders: (A.t, B.t, C.t) t list list
        val equalities: (A.t, B.t, C.t) t list list
      end

      module type S4 = sig
        type ('a, 'b, 'c, 'd) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        val orders: (A.t, B.t, C.t, D.t) t list list
        val equalities: (A.t, B.t, C.t, D.t) t list list
      end

      module type S5 = sig
        type ('a, 'b, 'c, 'd, 'e) t
        module A: Element
        module B: Element
        module C: Element
        module D: Element
        module E: Element
        val orders: (A.t, B.t, C.t, D.t, E.t) t list list
        val equalities: (A.t, B.t, C.t, D.t, E.t) t list list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include Equatable.Basic.S0 with type t := t
        include Representable.S0 with type t := t
      end

      module type S1 = sig
        include S1
        include Equatable.Basic.S1 with type 'a t := 'a t
        include Representable.S1 with type 'a t := 'a t
      end

      module type S2 = sig
        include S2
        include Equatable.Basic.S2 with type ('a, 'b) t := ('a, 'b) t
        include Representable.S2 with type ('a, 'b) t := ('a, 'b) t
      end

      module type S3 = sig
        include S3
        include Equatable.Basic.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
        include Representable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
      end

      module type S4 = sig
        include S4
        include Equatable.Basic.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
        include Representable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
      end

      module type S5 = sig
        include S5
        include Equatable.Basic.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
        include Representable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end

    module Make1(M: Testable.S1)(E: Examples.S1 with type 'a t := 'a M.t): sig
      val test: Test.t
    end

    module Make2(M: Testable.S2)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t): sig
      val test: Test.t
    end

    module Make3(M: Testable.S3)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t): sig
      val test: Test.t
    end

    module Make4(M: Testable.S4)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t): sig
      val test: Test.t
    end

    module Make5(M: Testable.S5)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t): sig
      val test: Test.t
    end
  end
end

module Ringoid: sig
  module Operators: sig
    module type S0 = sig
      type t
      val ( ~- ): t -> t
      val ( + ): t -> t -> t
      val ( - ): t -> t -> t
      val ( * ): t -> t -> t
      val ( / ): t -> t -> t
      val ( ** ): t -> int -> t
    end

    module Make0(M: sig
      type t
      val negate: t -> t
      val add: t -> t -> t
      val subtract: t -> t -> t
      val multiply: t -> t -> t
      val divide: t -> t -> t
      val exponentiate: t -> int -> t
    end): sig
      val ( ~- ): M.t -> M.t
      val ( + ): M.t -> M.t -> M.t
      val ( - ): M.t -> M.t -> M.t
      val ( * ): M.t -> M.t -> M.t
      val ( / ): M.t -> M.t -> M.t
      val ( ** ): M.t -> int -> M.t
    end
  end

  module Basic: sig
    module type S0 = sig
      type t
      val zero: t
      val one: t
      val negate: t -> t
      val add: t -> t -> t
      val subtract: t -> t -> t
      val multiply: t -> t -> t
      val divide: t -> t -> t
    end
  end

  module type S0 = sig
    include Basic.S0
    module O: Operators.S0 with type t := t
    val square: t -> t
    val exponentiate: t -> int -> t
  end

  module Subtract: sig
    module Make0(M: sig
      type t
      val negate: t -> t
      val add: t -> t -> t
    end): sig
      val subtract: M.t -> M.t -> M.t
    end
  end

  module Square: sig
    module Make0(M: sig
      type t
      val multiply: t -> t -> t
    end): sig
      val square: M.t -> M.t
    end
  end

  module Exponentiate: sig
    module Make0(M: sig
      type t
      val one: t
      val square: t -> t
      val multiply: t -> t -> t
      val exponentiate_negative_exponent: exponentiate:(t -> int -> t) -> t -> int -> t
    end): sig
      val exponentiate: M.t -> int -> M.t
    end
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        val additions: (t * t * t) list
        val negations: (t * t) list
        val multiplications: (t * t * t) list
        val divisions: (t * t * t) list
        val exponentiations: (t * int * t) list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include Equatable.Basic.S0 with type t := t
        include Representable.S0 with type t := t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module OfStandardNumbers: sig
  module type S0 = sig
    type t
    val of_int: int -> t
    val of_float: float -> t
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module ToStandardNumbers: sig
  module type S0 = sig
    type t
    val to_int: t -> int
    val to_float: t -> float
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end

module PredSucc: sig
  module type S0 = sig
    type t
    val pred: t -> t
    val succ: t -> t
  end

  module PredSucc: sig
    module Make0(M: sig
      type t
      val one: t
      val add: t -> t -> t
      val subtract: t -> t -> t
    end): sig
      val pred: M.t -> M.t
      val succ: M.t -> M.t
    end
  end

  module Tests: sig
    module Examples: sig
      module type S0 = sig
        type t
        val successions: (t * t) list
      end
    end

    module Testable: sig
      module type S0 = sig
        include S0
        include Equatable.Basic.S0 with type t := t
        include Representable.S0 with type t := t
      end
    end

    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t): sig
      val test: Test.t
    end
  end
end
