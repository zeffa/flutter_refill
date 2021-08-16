import 'package:dartz/dartz.dart';
import 'package:uji/core/errors/failures.dart';
import 'package:uji/features/auth/domain/entities/login_request.dart';
import 'package:uji/features/auth/domain/entities/login_response_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginResponse>> loginUser(Login login);
}
