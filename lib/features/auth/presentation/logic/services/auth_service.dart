import 'package:dartz/dartz.dart';
import 'package:uji/core/errors/failures.dart';
import 'package:uji/features/auth/domain/entities/login_request.dart';
import 'package:uji/features/auth/domain/entities/login_response_entity.dart';
import 'package:uji/features/auth/domain/usecases/login_user_service.dart';

class LoginService {
  final LoginUserService _loginUserService;

  LoginService(this._loginUserService);

  Future<Either<Failure, LoginResponse>> loginUser(
      String phone, String password) {
    return _loginUserService(Login(phone: phone, password: password));
  }
}
