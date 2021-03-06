// Mocks generated by Mockito 5.0.13 from annotations
// in uji/test/features/auth/data/repositories/login_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:uji/core/network/network_info.dart' as _i7;
import 'package:uji/features/auth/data/datasource/local_data_source.dart'
    as _i6;
import 'package:uji/features/auth/data/datasource/remote_data_source.dart'
    as _i3;
import 'package:uji/features/auth/data/models/login_response_model.dart' as _i2;
import 'package:uji/features/auth/domain/entities/login_request.dart' as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeLoginResponseModel extends _i1.Fake
    implements _i2.LoginResponseModel {}

/// A class which mocks [RemoteDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteDatasource extends _i1.Mock implements _i3.RemoteDatasource {
  MockRemoteDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.LoginResponseModel> loginUser(_i5.Login? login) =>
      (super.noSuchMethod(Invocation.method(#loginUser, [login]),
              returnValue: Future<_i2.LoginResponseModel>.value(
                  _FakeLoginResponseModel()))
          as _i4.Future<_i2.LoginResponseModel>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [LocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalDataSource extends _i1.Mock implements _i6.LocalDataSource {
  MockLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> cacheLoginResponse(
          _i2.LoginResponseModel? loginResponseModel) =>
      (super.noSuchMethod(
          Invocation.method(#cacheLoginResponse, [loginResponseModel]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<_i2.LoginResponseModel> getLoginResponse(_i5.Login? login) =>
      (super.noSuchMethod(Invocation.method(#getLoginResponse, [login]),
              returnValue: Future<_i2.LoginResponseModel>.value(
                  _FakeLoginResponseModel()))
          as _i4.Future<_i2.LoginResponseModel>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i7.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isInternetAvailable =>
      (super.noSuchMethod(Invocation.getter(#isInternetAvailable),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  String toString() => super.toString();
}
