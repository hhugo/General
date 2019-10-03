module Basic = struct
  type t = string

  open Int.O

  let repr x =
    Format.apply "%S" x

  let to_string = Function1.identity
  let of_string = Function1.identity
  let try_of_string = Option.some

  let of_bytes = OCamlStandard.Bytes.to_string
  let to_bytes = OCamlStandard.Bytes.of_string

  let get = OCamlStandard.String.get
  let set = OCamlStandard.Bytes.set

  let concat = OCamlStandard.Pervasives.( ^ )

  module O = struct
    include Compare.Poly.O
    include Equate.Poly.O

    let ( ^ ) = OCamlStandard.Pervasives.( ^ )
  end

  include (Compare.Poly: module type of Compare.Poly with module O := O)
  include (Equate.Poly: module type of Equate.Poly with module O := O)

  let size = OCamlStandard.String.length

  let of_char c =
    OCamlStandard.String.make 1 c

  let to_list s =
    let r = ref [] in
    for i = size s - 1 downto 0 do
      r := s.[i]::!r
    done;
    !r

  let of_list xs =
    let len = List.size xs in
    let r = OCamlStandard.Bytes.create len in
    xs
    |> List.iter_i ~f:(fun ~i x ->
      OCamlStandard.Bytes.set r i x
    );
    of_bytes r

  let substring s ~pos ~len =
    OCamlStandard.String.sub s pos len

  let prefix s ~len =
    substring s ~pos:0 ~len

  let suffix s ~len =
    substring s ~pos:(size s - len) ~len

  let has_prefix s ~pre =
    size s >= size pre
    && pre = prefix s ~len:(size pre)

  let has_suffix s ~suf =
    size s >= size suf
    && suf = suffix s ~len:(size suf)

  let drop_prefix' s ~len =
    substring s ~pos:len ~len:(size s - len)

  let drop_suffix' s ~len =
    substring s ~pos:0 ~len:(size s - len)

  let try_drop_suffix s ~suf =
    Option.some_if
      (has_suffix s ~suf)
      (lazy (drop_suffix' s ~len:(size suf)))

  let try_drop_prefix s ~pre =
    Option.some_if
      (has_prefix s ~pre)
      (lazy (drop_prefix' s ~len:(size pre)))

  let drop_suffix s ~suf =
    try_drop_suffix ~suf s
    |> Option.or_failure "String.drop_suffix"

  let drop_prefix s ~pre =
    try_drop_prefix ~pre s
    |> Option.or_failure "String.drop_prefix"

  let split s ~sep =
    let len = size sep in
    if len = 0 then Exception.invalid_argument "String.split: empty separator";
    let match_sep ~pos =
      pos >= 0
      && substring s ~pos ~len = sep
    in
    let rec aux ret last_pos = function
      | pos when match_sep ~pos ->
        aux ((substring s ~pos:(pos + len) ~len:(last_pos - pos -len))::ret) pos (pos - len)
      | pos when pos <= 0 ->
        (substring s ~pos:0 ~len:last_pos)::ret
      | pos ->
        aux ret last_pos (pos - 1)
    in
    match aux [] (size s) ((size s) - len) with
      | [""] -> []
      | parts -> parts

  let fold ~init s ~f =
    s
    |> to_list
    |> List.fold ~init ~f

  let filter s ~f =
    s
    |> to_list
    |> List.filter ~f
    |> of_list

  let split' s ~seps =
    let seps = SortedSet.Poly.of_list seps in
    let (parts, last_part) =
      s
      |> fold ~init:([], []) ~f:(fun (parts, current_part) c ->
        if SortedSet.Poly.contains seps ~v:c then
          (current_part::parts, [])
        else
          (parts, c::current_part)
      )
    in
    last_part::parts
    |> List.map ~f:List.reverse
    |> List.map ~f:of_list
    |> List.reverse
end

module Extended(Facets: Facets) = struct
  include Basic

  #ifdef TESTING_GENERAL
  module MakeTests(Standard: Standard) = struct
    open Standard

    #include "../Generated/Atoms/String.ml"

    include Tests_.Make(Basic)(struct
      let module_name = "String"

      let values = ["foo"; "bar"]

      let representations = [
        ("foo", "\"foo\"");
        ("bar\"baz", "\"bar\\\"baz\"");
      ]

      let conversions_to_string = [
        ("foo", "foo");
        ("bar\"baz", "bar\"baz");
      ]

      let conversions_from_string = conversions_to_string

      let unconvertible_strings = []

      let equalities = []

      let differences = [
        ("foo", "bar");
      ]

      let strict_orders = [
        ["aaaa"; "aaaaa"; "aaaab"; "ab"; "b"];
      ]

      let order_classes = []
    end)(struct
      open Testing

      let tests = (
        let make s seps expected =
          ~: "String: split %S %S" s (of_list seps) (lazy (
            check_string_list ~expected (split' s ~seps)
          ))
        in
        [
          make "abcdefghfj" ['c'; 'f'] ["ab"; "de"; "gh"; "j"];
          make "xabxxcdx" ['x'] [""; "ab"; ""; "cd"; ""];
        ]
      )
    end)
  end
  #endif
end
