import 'package:dartz/dartz.dart';
import 'package:uji/core/errors/exceptions.dart';
import 'package:uji/core/errors/failures.dart';
import 'package:uji/core/network/network_info.dart';
import 'package:uji/features/auth/data/datasource/local_data_source.dart';
import 'package:uji/features/auth/data/datasource/remote_data_source.dart';
import 'package:uji/features/auth/domain/entities/login_request.dart';
import 'package:uji/features/auth/domain/entities/login_response_entity.dart';
import 'package:uji/features/auth/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final RemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;
  final LocalDataSource localDataSource;

  LoginRepositoryImpl(
      {required this.remoteDatasource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, LoginResponse>> loginUser(Login login) async {
    if (await networkInfo.isInternetAvailable) {
      try {
        final loginResponse = await remoteDatasource.loginUser(login);
        localDataSource.cacheLoginResponse(loginResponse);
        return Right(loginResponse);
      } on ServerException catch(e) {
        return Left(LoginFailure(e.message));
      } on CacheException {
        return Left(CacheFailure());
      }
    } else {
      try{
        final localData = await localDataSource.getLoginResponse(login);
        return Right(localData);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
