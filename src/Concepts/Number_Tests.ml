include (Concepts_.Number_: module type of Concepts_.Number_)

module Tests = struct
  module Make0(M: S0)(E: Examples.S0 with type t := M.t) = struct
    open Testing

    open M

    module E = struct
      include E

      let equal = equal @ [
        [zero; of_int 0; of_float 0.; of_string "0"];
        [one; of_int 1; of_float 1.; of_string "1"];
      ]

      let different = different @ [
        (zero, one);
      ]
    end

    let test = "Number" >:: [
      (let module T = Traits_Tests.Representable_Tests.Tests.Make0(M)(E) in T.test);
      (let module T = Traits_Tests.Equatable_Tests.Tests.Make0(M)(E) in T.test);
      (let module T = Traits_Tests.Ringoid_Tests.Tests.Make0(M)(E) in T.test);
    ]
  end
end
