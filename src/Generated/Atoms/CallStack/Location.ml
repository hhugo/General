module Tests_ = struct
  module type Examples = sig
    include Facets.Able.Tests.Examples.S0 with type t := OCamlStandard.Printexc.location
  end

  module type Testable = sig
    type t = OCamlStandard.Printexc.location
    include Facets.Able.Tests.Testable.S0 with type t := t
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Location" >:: OCamlStandard.Pervasives.( @ ) [
      (let module T = Facets.Able.Tests.Make0(M)(E) in T.test);
    ] Tests.tests
  end
end