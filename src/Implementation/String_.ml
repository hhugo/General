include Foundations.String_

module Tests = struct
  open Testing

  module Examples = struct
    let repr = [
      ("foo", "\"foo\"");
      ("bar\"baz", "\"bar\\\"baz\"");
    ]

    let equal = [
      ["foo"];
    ]

    let different = [
      ("foo", "bar");
    ]
  end

  let test = "String" >:: [
    (let module T = Traits.Representable.Tests.Make0(Foundations.String_)(Examples) in T.test);
    (let module T = Traits.Equatable.Tests.Make0(Foundations.String_)(Examples) in T.test);
  ]
end