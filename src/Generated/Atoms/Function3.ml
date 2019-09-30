module Tests_ = struct
  module type Examples = sig
  end

  module type Testable = sig
  end

  module Make(M: Testable)(E: Examples)(Tests: sig val tests: Test.t list end) = struct
    open Testing
    let test = "Function3" >:: OCSP.(@) [
    ] Tests.tests
  end
end
