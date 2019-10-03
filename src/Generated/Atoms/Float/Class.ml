module Tests_ = struct
  module type Examples = sig
    include Facets.Able.Tests.Examples.S0 with type t := Class.t
  end

  module type Testable = sig
    type t = Class.t = Normal | SubNormal | Zero | Infinite | NotANumber
    include Facets.Able.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Class" >:: OCamlStandard.Pervasives.( @ ) [
      (let module T = Facets.Able.Tests.Make0(M)(E) in T.test);
    ] Tests.tests
  end
end