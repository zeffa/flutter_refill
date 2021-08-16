import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uji/core/errors/failures.dart';
import 'package:uji/features/auth/domain/entities/login_request.dart';
import 'package:uji/features/auth/domain/entities/login_response_entity.dart';
import 'package:uji/features/auth/domain/repositories/login_repository.dart';
import 'package:uji/features/auth/domain/usecases/login_user_service.dart';

import 'login_user_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  late MockLoginRepository mockLoginRepository;
  late LoginUserService loginUserService;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    loginUserService = LoginUserService(mockLoginRepository);
  });

  test("should login user", () async {
    final login = Login(phone: "0700", password: "123456");
    final loginResponse = LoginResponse(
        email: "zeffah@gmail.com",
        phone: "0700",
        token: "token",
        userId: 1,
        userLevel: 1);
    //Arrange
    when(mockLoginRepository.loginUser(login))
        .thenAnswer((_) async => Right(loginResponse));
    //Act
    final result = await loginUserService(login);
    //assert
    expect(result, Right(loginResponse));
    verify(mockLoginRepository.loginUser(login));
    verifyNoMoreInteractions(mockLoginRepository);
  });

  test("should return a failure", () async {
    final login = Login(phone: "Wrong phone", password: "password");
    final loginFailure = LoginFailure("message");
    //Arrange
    when(mockLoginRepository.loginUser(login))
        .thenAnswer((_) async => Left(loginFailure));
    //Act
    final result = await loginUserService(login);
    //assert
    expect(result, Left(loginFailure));
    verify(mockLoginRepository.loginUser(login));
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
