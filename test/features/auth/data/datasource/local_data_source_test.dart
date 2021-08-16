import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uji/core/errors/exceptions.dart';
import 'package:uji/core/utils/constants.dart';
import 'package:uji/features/auth/data/datasource/local_data_source.dart';
import 'package:uji/features/auth/data/models/login_response_model.dart';
import 'package:uji/features/auth/domain/entities/login_request.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late LocalDataSourceImpl localDataSource;

  setUp((){
    mockSharedPreferences = MockSharedPreferences();
    localDataSource =
        LocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('Fetch Shared Preferences', () {
    String jsonFixture = fixture("login_response_shared.json");
    final LoginResponseModel loginResponseModel =
        LoginResponseModel.fromJson(jsonDecode(jsonFixture));

    test('can get stored login response from shared preferences', () async {
      when(mockSharedPreferences.getString(any)).thenReturn(jsonFixture);
      final result = await localDataSource.getLoginResponse(
          Login(phone: "0700", password: "123456"));
      verify(mockSharedPreferences.getString(LOGIN_RESPONSE_PREFERENCE));
      expect(result, loginResponseModel);
    });

    test('should throw Exception when login response cached not found',
        () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      final login = Login(phone: "0700", password: "123456");
      final functionCall = localDataSource.getLoginResponse;
      expect(() => functionCall(login), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('Cache Login Response', () {
    final LoginResponseModel loginResponseModel = LoginResponseModel.empty();
    test('Should call the shared preference save', () async {
      when(mockSharedPreferences.setString(LOGIN_RESPONSE_PREFERENCE,
              jsonEncode(loginResponseModel.toJson())))
          .thenAnswer((_) async => true);
      localDataSource.cacheLoginResponse(loginResponseModel);
      final expected = jsonEncode(loginResponseModel.toJson());
      verify(
        mockSharedPreferences.setString(LOGIN_RESPONSE_PREFERENCE, expected),
      );
    });
  });
}
