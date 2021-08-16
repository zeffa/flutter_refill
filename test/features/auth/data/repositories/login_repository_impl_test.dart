import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uji/core/errors/exceptions.dart';
import 'package:uji/core/errors/failures.dart';
import 'package:uji/core/network/network_info.dart';
import 'package:uji/features/auth/data/datasource/local_data_source.dart';
import 'package:uji/features/auth/data/datasource/remote_data_source.dart';
import 'package:uji/features/auth/data/models/login_response_model.dart';
import 'package:uji/features/auth/data/repositories/login_repository_impl.dart';
import 'package:uji/features/auth/domain/entities/login_request.dart';
import 'package:uji/features/auth/domain/entities/login_response_entity.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([RemoteDatasource, LocalDataSource, NetworkInfo])
void main() {
  late MockRemoteDatasource mockRemoteDatasource;
  late MockLocalDataSource mockLocalDatasource;
  late MockNetworkInfo mockNetworkInfo;
  late LoginRepositoryImpl repository;

  setUp((){
    mockRemoteDatasource = MockRemoteDatasource();
    mockLocalDatasource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LoginRepositoryImpl(
        remoteDatasource: mockRemoteDatasource,
        localDataSource: mockLocalDatasource,
        networkInfo: mockNetworkInfo);
  });

  group('Internet Available', () {
    test('should verify if internet is available', () async {
      final login = Login(phone: "0700", password: "123456");
      final loginResponseModel = LoginResponseModel(
          email: "zeffah@gmail.com",
          phone: "0700",
          token: "token",
          userId: 1,
          userLevel: 1);
      when(mockNetworkInfo.isInternetAvailable).thenAnswer((_) async => true);
      when(mockRemoteDatasource.loginUser(login))
          .thenAnswer((_) async => loginResponseModel);
      repository.loginUser(login);
      verify(mockNetworkInfo.isInternetAvailable);
    });
  });

  group('Device Online', () {
    final login = Login(phone: "0700", password: "123456");
    final loginResponseModel = LoginResponseModel(
        email: "zeffah@gmail.com",
        phone: "0700",
        token: "token1",
        userId: 1,
        userLevel: 1);
    final LoginResponse loginResponse = loginResponseModel;
    setUp(() {
      when(mockNetworkInfo.isInternetAvailable).thenAnswer((_) async => true);
    });
    test('should return login response when device is online', () async {
      when(mockRemoteDatasource.loginUser(login))
          .thenAnswer((_) async => loginResponseModel);
      final result = await repository.loginUser(login);
      verify(mockRemoteDatasource.loginUser(login));
      expect(result, equals(Right(loginResponse)));
    });

    test('should cache data locally when remote data fetched', () async {
      when(mockRemoteDatasource.loginUser(login))
          .thenAnswer((_) async => loginResponseModel);
      await repository.loginUser(login);
      verify(mockRemoteDatasource.loginUser(login));
      verify(mockLocalDatasource.cacheLoginResponse(loginResponseModel));
    });

    test('should throw Login failure when remote call is unsuccessful', () async {
      String message = "message";
      when(mockRemoteDatasource.loginUser(login))
          .thenThrow(ServerException(message: message, code: 0));
      final result = await repository.loginUser(login);
      verify(mockRemoteDatasource.loginUser(login));
      verifyZeroInteractions(mockLocalDatasource);
      expect(result, equals(Left(LoginFailure(message))));
    });
  });

  group('Device is Offline', () {
    final login = Login(phone: "0700", password: "123456");
    final loginResponseModel = LoginResponseModel(
        email: "zeffah@gmail.com",
        phone: "0700",
        token: "token",
        userId: 1,
        userLevel: 1);
    setUp(() {
      when(mockNetworkInfo.isInternetAvailable).thenAnswer((_) async => false);
    });
    test('should return cached data if present', () async {
      when(mockLocalDatasource.getLoginResponse(login)).thenAnswer((_) async => loginResponseModel);
      final result = await repository.loginUser(login);
      verify(mockNetworkInfo.isInternetAvailable);
      verify(mockLocalDatasource.getLoginResponse(login));
      verifyZeroInteractions(mockRemoteDatasource);
      expect(result, equals(Right(loginResponseModel)));
    });

    test('should throw cache failure when no cached data present', () async {
      when(mockLocalDatasource.getLoginResponse(login))
          .thenThrow(CacheException());
      final result = await repository.loginUser(login);
      verify(mockLocalDatasource.getLoginResponse(login));
      verifyZeroInteractions(mockRemoteDatasource);
      expect(result, equals(Left(CacheFailure())));
    });

    // test('should return login failure when device is offline and cache exception is thrown', () async {
    //   final login = Login(phone: "0700", password: "123456");
    //   when(mockLocalDatasource.getLoginResponse(login))
    //       .thenThrow(CacheException());
    //   final result = await repository.loginUser(login);
    //   verifyZeroInteractions(mockRemoteDatasource);
    //   verify(mockLocalDatasource.getLoginResponse(login));
    // });
  });
}
