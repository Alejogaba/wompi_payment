// Mocks generated by Mockito 5.3.0 from annotations
// in wompi_payment_colombia/test/services/wompi_acceptance_token_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mockito/mockito.dart' as _i1;
import 'package:wompi_payment_colombia/src/models/response_models/acceptance_response_model.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeData_0 extends _i1.SmartFake implements _i2.Data {
  _FakeData_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [AcceptanceResponse].
///
/// See the documentation for Mockito's code generation for more information.
class MockAcceptanceResponse extends _i1.Mock
    implements _i2.AcceptanceResponse {
  MockAcceptanceResponse() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Data get data => (super.noSuchMethod(Invocation.getter(#data),
      returnValue: _FakeData_0(this, Invocation.getter(#data))) as _i2.Data);
  @override
  set data(_i2.Data? _data) =>
      super.noSuchMethod(Invocation.setter(#data, _data),
          returnValueForMissingStub: null);
  @override
  Map<String, dynamic> toJson() =>
      (super.noSuchMethod(Invocation.method(#toJson, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
}
