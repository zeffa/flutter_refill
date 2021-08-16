import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:uji/features/auth/data/models/login_response_model.dart';
import 'package:uji/features/auth/domain/entities/login_response_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final loginResponseModel = LoginResponseModel(
      email: "zeffah@gmail.com",
      phone: "0700",
      token: "token",
      userId: 1,
      userLevel: 1);
  test('should be a subclass of LoginResponse entity', () {
    expect(loginResponseModel, isA<LoginResponse>());
  });

  group('model from json', () {
    test('should return valid model from json', () {
      Map<String, dynamic> jsonMap = jsonDecode(fixture('login_response.json'));
      final result = LoginResponseModel.fromJson(jsonMap);
      expect(result, loginResponseModel);
    });
  });

  group('to json from model', () {
    test('should return valid json from model', () {
      Map<String, dynamic> jsonMap = {
        "access_token": "token",
        "phone": "0700",
        "email": "zeffah@gmail.com",
        "id": 1,
        "user_level": 1,
      };
      final result = loginResponseModel.toJson();
      expect(result, jsonMap);
    });
  });
}
