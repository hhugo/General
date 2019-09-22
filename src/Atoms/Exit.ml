#include "../Generated/Atoms/Exit.ml"

module Self = struct
    type t =
    | Success
    | Failure of int

    let of_int = function
    | 0 -> Success
    | n -> Failure n

    let to_int = function
    | Success -> 0
    | Failure n -> n

    let exit status =
    OCSP.exit (to_int status)

    let at_exit = OCSP.at_exit
end

include Self

(*
module Tests = Tests_.Make(Self)(struct
end)(struct
    let tests = []
end)
*)
