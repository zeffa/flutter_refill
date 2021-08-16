import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uji/core/errors/exceptions.dart';
import 'package:uji/core/utils/constants.dart';
import 'package:uji/features/auth/data/datasource/remote_data_source.dart';
import 'package:uji/features/auth/data/models/login_response_model.dart';
import 'package:uji/features/auth/domain/entities/login_request.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockHttpClient;
  late RemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockHttpClient = MockClient();
    remoteDataSource = RemoteDataSourceImpl(httpClient: mockHttpClient);
  });

  void mockSuccessResponse(String response) {
    when(mockHttpClient.post(any, body: anyNamed('body')))
        .thenAnswer((_) async => http.Response(response, 200));
  }

  void mockErrorResponse() {
    when(mockHttpClient.post(any, body: anyNamed('body'))).thenAnswer(
        (_) async =>
            http.Response(jsonEncode({"message": "Error from server"}), 401));
  }

  group('User Login', () {
    final loginUrl = Uri.parse(DEVELOPMENT_BASE_URL + "auth/login");
    final login = Login(phone: "+254706567060", password: "123456");
    final response = fixture("login_response.json");

    test('should verify if post was called with proper parameters', () async {
      mockSuccessResponse(response);
      remoteDataSource.loginUser(login);
      verify(mockHttpClient.post(loginUrl, body: login.toJson()));
    });

    test('should return valid LoginResponse when statusCode is 200', () async {
      final loginResponse = LoginResponseModel.fromJson(jsonDecode(response));
      mockSuccessResponse(response);
      final result = await remoteDataSource.loginUser(login);
      expect(result, loginResponse);
    });

    test('should throw exception when status code not 200', () async {
      mockErrorResponse();
      final call = remoteDataSource.loginUser;
      expect(() => call(login), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
