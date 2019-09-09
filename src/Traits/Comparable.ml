#ext python3
from geni import *
generate(comparable.implementation_items)
#endext

(* @feature Descending, ascending *)

module GreaterLessThan = struct
  module Make0(M: sig
    type t

    val compare: t -> t
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y =
      match compare x y with
        | LT -> true
        | _ -> false

    let less_or_equal x y =
      match compare x y with
        | GT -> false
        | _ -> true

    let greater_than x y =
      match compare x y with
        | GT -> true
        | _ -> false

    let greater_or_equal x y =
      match compare x y with
        | LT -> false
        | _ -> true
  end

  module Make1(M: sig
    type 'a t

    val compare: 'a t -> 'a t
      -> compare_a:('a -> 'a -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare_a =
      match compare x y ~compare_a with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare_a =
      match compare x y ~compare_a with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare_a =
      match compare x y ~compare_a with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare_a =
      match compare x y ~compare_a with
        | LT -> false
        | _ -> true
  end

  module Make2(M: sig
    type ('a, 'b) t

    val compare: ('a, 'b) t -> ('a, 'b) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with
        | LT -> false
        | _ -> true
  end

  module Make3(M: sig
    type ('a, 'b, 'c) t

    val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with
        | LT -> false
        | _ -> true
  end

  module Make4(M: sig
    type ('a, 'b, 'c, 'd) t

    val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with
        | LT -> false
        | _ -> true
  end

  module Make5(M: sig
    type ('a, 'b, 'c, 'd, 'e) t

    val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> compare_e:('e -> 'e -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let less_than x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with
        | LT -> true
        | _ -> false

    let less_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with
        | GT -> false
        | _ -> true

    let greater_than x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with
        | GT -> true
        | _ -> false

    let greater_or_equal x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with
        | LT -> false
        | _ -> true
  end
end

module Between = struct
  module Make0(M: sig
    type t

    val less_than: t -> t
      -> bool
    val less_or_equal: t -> t
      -> bool
    val greater_than: t -> t
      -> bool
    val greater_or_equal: t -> t
      -> bool
  end) = struct
    open M

    let between x ~low ~high =
      less_than low x
      && greater_than high x

    let between_or_equal x ~low ~high =
      less_or_equal low x
      && greater_or_equal high x
  end

  module Make1(M: sig
    type 'a t

    val less_than: 'a t -> 'a t
      -> compare_a:('a -> 'a -> Compare.t)
      -> bool
    val less_or_equal: 'a t -> 'a t
      -> compare_a:('a -> 'a -> Compare.t)
      -> bool
    val greater_than: 'a t -> 'a t
      -> compare_a:('a -> 'a -> Compare.t)
      -> bool
    val greater_or_equal: 'a t -> 'a t
      -> compare_a:('a -> 'a -> Compare.t)
      -> bool
  end) = struct
    open M
    open Compare

    let between x ~low ~high ~compare_a =
      less_than low x ~compare_a
      && greater_than high x ~compare_a

    let between_or_equal x ~low ~high ~compare_a =
      less_or_equal low x ~compare_a
      && greater_or_equal high x ~compare_a
  end

  module Make2(M: sig
    type ('a, 'b) t

    val less_than: ('a, 'b) t -> ('a, 'b) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> bool
    val less_or_equal: ('a, 'b) t -> ('a, 'b) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> bool
    val greater_than: ('a, 'b) t -> ('a, 'b) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> bool
    val greater_or_equal: ('a, 'b) t -> ('a, 'b) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> bool
  end) = struct
    open M

    let between x ~low ~high ~compare_a ~compare_b =
      less_than low x ~compare_a ~compare_b
      && greater_than high x ~compare_a ~compare_b

    let between_or_equal x ~low ~high ~compare_a ~compare_b =
      less_or_equal low x ~compare_a ~compare_b
      && greater_or_equal high x ~compare_a ~compare_b
  end

  module Make3(M: sig
    type ('a, 'b, 'c) t

    val less_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> bool
    val less_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> bool
    val greater_than: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> bool
    val greater_or_equal: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> bool
  end) = struct
    open M

    let between x ~low ~high ~compare_a ~compare_b ~compare_c =
      less_than low x ~compare_a ~compare_b ~compare_c
      && greater_than high x ~compare_a ~compare_b ~compare_c

    let between_or_equal x ~low ~high ~compare_a ~compare_b ~compare_c =
      less_or_equal low x ~compare_a ~compare_b ~compare_c
      && greater_or_equal high x ~compare_a ~compare_b ~compare_c
  end

  module Make4(M: sig
    type ('a, 'b, 'c, 'd) t

    val less_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> bool
    val less_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> bool
    val greater_than: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> bool
    val greater_or_equal: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> bool
  end) = struct
    open M

    let between x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d =
      less_than low x ~compare_a ~compare_b ~compare_c ~compare_d
      && greater_than high x ~compare_a ~compare_b ~compare_c ~compare_d

    let between_or_equal x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d =
      less_or_equal low x ~compare_a ~compare_b ~compare_c ~compare_d
      && greater_or_equal high x ~compare_a ~compare_b ~compare_c ~compare_d
  end

  module Make5(M: sig
    type ('a, 'b, 'c, 'd, 'e) t

    val less_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> compare_e:('e -> 'e -> Compare.t)
      -> bool
    val less_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> compare_e:('e -> 'e -> Compare.t)
      -> bool
    val greater_than: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> compare_e:('e -> 'e -> Compare.t)
      -> bool
    val greater_or_equal: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> compare_e:('e -> 'e -> Compare.t)
      -> bool
  end) = struct
    open M

    let between x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      less_than low x ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e
      && greater_than high x ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e

    let between_or_equal x ~low ~high ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      less_or_equal low x ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e
      && greater_or_equal high x ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e
  end
end

module MinMax = struct
  module Make0(M: sig
    type t

    val compare: t -> t
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y =
      match compare x y with LT -> x | GT | EQ -> y

    let max x y =
      match compare x y with GT -> x | LT | EQ -> y

    let min_max x y =
      match compare x y with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make1(M: sig
    type 'a t

    val compare: 'a t -> 'a t
      -> compare_a:('a -> 'a -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare_a =
      match compare x y ~compare_a with LT -> x | GT | EQ -> y

    let max x y ~compare_a =
      match compare x y ~compare_a with GT -> x | LT | EQ -> y

    let min_max x y ~compare_a =
      match compare x y ~compare_a with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make2(M: sig
    type ('a, 'b) t

    val compare: ('a, 'b) t -> ('a, 'b) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with LT -> x | GT | EQ -> y

    let max x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with GT -> x | LT | EQ -> y

    let min_max x y ~compare_a ~compare_b =
      match compare x y ~compare_a ~compare_b with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make3(M: sig
    type ('a, 'b, 'c) t

    val compare: ('a, 'b, 'c) t -> ('a, 'b, 'c) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with LT -> x | GT | EQ -> y

    let max x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with GT -> x | LT | EQ -> y

    let min_max x y ~compare_a ~compare_b ~compare_c =
      match compare x y ~compare_a ~compare_b ~compare_c with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make4(M: sig
    type ('a, 'b, 'c, 'd) t

    val compare: ('a, 'b, 'c, 'd) t -> ('a, 'b, 'c, 'd) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with LT -> x | GT | EQ -> y

    let max x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with GT -> x | LT | EQ -> y

    let min_max x y ~compare_a ~compare_b ~compare_c ~compare_d =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d with LT -> (x, y) | GT | EQ -> (y, x)
  end

  module Make5(M: sig
    type ('a, 'b, 'c, 'd, 'e) t

    val compare: ('a, 'b, 'c, 'd, 'e) t -> ('a, 'b, 'c, 'd, 'e) t
      -> compare_a:('a -> 'a -> Compare.t)
      -> compare_b:('b -> 'b -> Compare.t)
      -> compare_c:('c -> 'c -> Compare.t)
      -> compare_d:('d -> 'd -> Compare.t)
      -> compare_e:('e -> 'e -> Compare.t)
      -> Compare.t
  end) = struct
    open M
    open Compare

    let min x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with LT -> x | GT | EQ -> y

    let max x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with GT -> x | LT | EQ -> y

    let min_max x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e =
      match compare x y ~compare_a ~compare_b ~compare_c ~compare_d ~compare_e with LT -> (x, y) | GT | EQ -> (y, x)
  end
end

module Tests = struct
  open Testing

#ext python3
from geni import *
generate(comparable.tests_examples_implementation, indent=1)
#endext

  module Make0(M: sig
    include S0
    include Representable.S0 with type t := t
    include Equatable.Basic.S0 with type t := t
  end)(E: Examples.S0 with type t := M.t): sig val test: Test.t end = struct
    open M
    open M.O

    let check_pair =
      check
        ~repr:(Tuples.Tuple2.repr ~repr_a:repr ~repr_b:repr)
        ~equal:(Tuples.Tuple2.equal ~equal_a:equal ~equal_b:equal)

    let check = check ~repr ~equal

    let test = "Comparable" >:: (
      E.ordered
      |> List.flat_map ~f:(fun xs ->
        List.fold ~init:(List.head xs, []) (List.tail xs) ~f:(fun (x, tests) y ->
          let rx = repr x and ry = repr y in
          let new_tests = [
            ~: "less_than %s %s" rx ry (lazy (check_true (less_than x y)));
            ~: "less_or_equal %s %s" rx ry (lazy (check_true (less_or_equal x y)));
            ~: "greater_or_equal %s %s" rx ry (lazy (check_false (greater_or_equal x y)));
            ~: "greater_than %s %s" rx ry (lazy (check_false (greater_than x y)));
            ~: "%s < %s" rx ry (lazy (check_true (x < y)));
            ~: "%s <= %s" rx ry (lazy (check_true (x <= y)));
            ~: "%s >= %s" rx ry (lazy (check_false (x >= y)));
            ~: "%s > %s" rx ry (lazy (check_false (x > y)));
            ~: "min %s %s" rx ry (lazy (check ~expected:x (min x y)));
            ~: "max %s %s" rx ry (lazy (check ~expected:y (max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(x, y) (min_max x y)));

            ~: "less_than %s %s" ry rx (lazy (check_false (less_than y x)));
            ~: "less_or_equal %s %s" ry rx (lazy (check_false (less_or_equal y x)));
            ~: "greater_or_equal %s %s" ry rx (lazy (check_true (greater_or_equal y x)));
            ~: "greater_than %s %s" ry rx (lazy (check_true (greater_than y x)));
            ~: "%s < %s" ry rx (lazy (check_false (y < x)));
            ~: "%s <= %s" ry rx (lazy (check_false (y <= x)));
            ~: "%s >= %s" ry rx (lazy (check_true (y >= x)));
            ~: "%s > %s" ry rx (lazy (check_true (y > x)));
            ~: "min %s %s" ry rx (lazy (check ~expected:x (min y x)));
            ~: "max %s %s" ry rx (lazy (check ~expected:y (max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(x, y) (min_max y x)));
          ] in
          (y, new_tests @ tests)
        )
        |> Tuples.Tuple2.get_1
      )
    ) @ (
      E.equal
      |> List.flat_map ~f:(fun xs ->
        List.cartesian_product xs xs
        |> List.flat_map ~f:(fun (x, y) ->
          let rx = repr x and ry = repr y in
          [
            ~: "less_than %s %s" rx ry (lazy (check_false (less_than x y)));
            ~: "less_or_equal %s %s" rx ry (lazy (check_true (less_or_equal x y)));
            ~: "greater_or_equal %s %s" rx ry (lazy (check_true (greater_or_equal x y)));
            ~: "greater_than %s %s" rx ry (lazy (check_false (greater_than x y)));
            ~: "%s < %s" rx ry (lazy (check_false (x < y)));
            ~: "%s <= %s" rx ry (lazy (check_true (x <= y)));
            ~: "%s >= %s" rx ry (lazy (check_true (x >= y)));
            ~: "%s > %s" rx ry (lazy (check_false (x > y)));
            ~: "min %s %s" rx ry (lazy (check ~expected:x (min x y)));
            ~: "min %s %s" rx ry (lazy (check ~expected:y (min x y)));
            ~: "max %s %s" rx ry (lazy (check ~expected:x (max x y)));
            ~: "max %s %s" rx ry (lazy (check ~expected:y (max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(x, y) (min_max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(y, x) (min_max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(x, x) (min_max x y)));
            ~: "min_max %s %s" rx ry (lazy (check_pair ~expected:(y, y) (min_max x y)));

            ~: "less_than %s %s" ry rx (lazy (check_false (less_than y x)));
            ~: "less_or_equal %s %s" ry rx (lazy (check_true (less_or_equal y x)));
            ~: "greater_or_equal %s %s" ry rx (lazy (check_true (greater_or_equal y x)));
            ~: "greater_than %s %s" ry rx (lazy (check_false (greater_than y x)));
            ~: "%s < %s" ry rx (lazy (check_false (y < x)));
            ~: "%s <= %s" ry rx (lazy (check_true (y <= x)));
            ~: "%s >= %s" ry rx (lazy (check_true (y >= x)));
            ~: "%s > %s" ry rx (lazy (check_false (y > x)));
            ~: "min %s %s" ry rx (lazy (check ~expected:x (min y x)));
            ~: "min %s %s" ry rx (lazy (check ~expected:y (min y x)));
            ~: "max %s %s" ry rx (lazy (check ~expected:x (max y x)));
            ~: "max %s %s" ry rx (lazy (check ~expected:y (max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(x, y) (min_max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(y, x) (min_max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(x, x) (min_max y x)));
            ~: "min_max %s %s" ry rx (lazy (check_pair ~expected:(y, y) (min_max y x)));
          ]
        )
      )
    )
  end

  module Make1(M: sig
    include S1
    include Equatable.Basic.S1 with type 'a t := 'a t
    include Representable.S1 with type 'a t := 'a t
  end)(E: Examples.S1 with type 'a t := 'a M.t): sig val test: Test.t end = Make0(struct
    include Specialize1(M)(E.A)
    include (Representable.Specialize1(M)(E.A): Representable.S0 with type t := t)
    include (Equatable.Basic.Specialize1(M)(E.A): Equatable.Basic.S0 with type t := t)
  end)(E)

  module Make2(M: sig
    include S2
    include Equatable.Basic.S2 with type ('a, 'b) t := ('a, 'b) t
    include Representable.S2 with type ('a, 'b) t := ('a, 'b) t
  end)(E: Examples.S2 with type ('a, 'b) t := ('a, 'b) M.t): sig val test: Test.t end = Make0(struct
    include Specialize2(M)(E.A)(E.B)
    include (Representable.Specialize2(M)(E.A)(E.B): Representable.S0 with type t := t)
    include (Equatable.Basic.Specialize2(M)(E.A)(E.B): Equatable.Basic.S0 with type t := t)
  end)(E)

  module Make3(M: sig
    include S3
    include Equatable.Basic.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
    include Representable.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) t
  end)(E: Examples.S3 with type ('a, 'b, 'c) t := ('a, 'b, 'c) M.t): sig val test: Test.t end = Make0(struct
    include Specialize3(M)(E.A)(E.B)(E.C)
    include (Representable.Specialize3(M)(E.A)(E.B)(E.C): Representable.S0 with type t := t)
    include (Equatable.Basic.Specialize3(M)(E.A)(E.B)(E.C): Equatable.Basic.S0 with type t := t)
  end)(E)

  module Make4(M: sig
    include S4
    include Equatable.Basic.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
    include Representable.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) t
  end)(E: Examples.S4 with type ('a, 'b, 'c, 'd) t := ('a, 'b, 'c, 'd) M.t): sig val test: Test.t end = Make0(struct
    include Specialize4(M)(E.A)(E.B)(E.C)(E.D)
    include (Representable.Specialize4(M)(E.A)(E.B)(E.C)(E.D): Representable.S0 with type t := t)
    include (Equatable.Basic.Specialize4(M)(E.A)(E.B)(E.C)(E.D): Equatable.Basic.S0 with type t := t)
  end)(E)

  module Make5(M: sig
    include S5
    include Equatable.Basic.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
    include Representable.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) t
  end)(E: Examples.S5 with type ('a, 'b, 'c, 'd, 'e) t := ('a, 'b, 'c, 'd, 'e) M.t): sig val test: Test.t end = Make0(struct
    include Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E)
    include (Representable.Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E): Representable.S0 with type t := t)
    include (Equatable.Basic.Specialize5(M)(E.A)(E.B)(E.C)(E.D)(E.E): Equatable.Basic.S0 with type t := t)
  end)(E)
end
