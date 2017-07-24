include (Concepts_.Integer_: module type of Concepts_.Integer_)

module Tests = struct
  module Make0(M: S0)(E: Concepts_.RealNumber_.Examples.S0 with type t := M.t) = struct
    open Testing

    open M

    let test = "Integer" >:: [
      (let module T = RealNumber_Tests.Tests.Make0(M)(E) in T.test);
      "succ zero" >: (lazy (check ~repr ~equal ~expected:one (succ zero)));
      "pred one" >: (lazy (check ~repr ~equal ~expected:zero (pred one)));
    ]
  end
end
