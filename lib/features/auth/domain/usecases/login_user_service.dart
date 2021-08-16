import 'package:dartz/dartz.dart';
import 'package:uji/core/errors/failures.dart';
import 'package:uji/core/usecases/use_case_service.dart';
import 'package:uji/features/auth/domain/entities/login_request.dart';
import 'package:uji/features/auth/domain/entities/login_response_entity.dart';
import 'package:uji/features/auth/domain/repositories/login_repository.dart';

class LoginUserService implements UseCaseService<LoginResponse, Login> {
  final LoginRepository repository;

  LoginUserService(this.repository);

  @override
  Future<Either<Failure, LoginResponse>> call(Login params) async {
    return await repository.loginUser(params);
  }
}
