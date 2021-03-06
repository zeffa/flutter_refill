// Mocks generated by Mockito 5.0.13 from annotations
// in uji/test/features/auth/domain/usecases/login_user_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:uji/core/errors/failures.dart' as _i5;
import 'package:uji/features/auth/domain/entities/login_request.dart' as _i7;
import 'package:uji/features/auth/domain/entities/login_response_entity.dart'
    as _i6;
import 'package:uji/features/auth/domain/repositories/login_repository.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [LoginRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginRepository extends _i1.Mock implements _i3.LoginRepository {
  MockLoginRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.LoginResponse>> loginUser(
          _i7.Login? login) =>
      (super.noSuchMethod(Invocation.method(#loginUser, [login]),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.LoginResponse>>.value(
              _FakeEither<_i5.Failure, _i6.LoginResponse>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.LoginResponse>>);
  @override
  String toString() => super.toString();
}
