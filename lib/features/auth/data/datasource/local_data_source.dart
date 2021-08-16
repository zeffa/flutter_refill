import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uji/core/errors/exceptions.dart';
import 'package:uji/core/utils/constants.dart';
import 'package:uji/features/auth/data/models/login_response_model.dart';
import 'package:uji/features/auth/domain/entities/login_request.dart';

abstract class LocalDataSource {
  Future<void> cacheLoginResponse(LoginResponseModel loginResponseModel);

  Future<LoginResponseModel> getLoginResponse(Login login);
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<LoginResponseModel> getLoginResponse(Login login) {
    final jsonStr = sharedPreferences.getString(LOGIN_RESPONSE_PREFERENCE);
    if (jsonStr != null) {
      return Future.value(LoginResponseModel.fromJson(jsonDecode(jsonStr)));
    }
    throw CacheException();
  }

  @override
  Future<void> cacheLoginResponse(LoginResponseModel loginResponseModel) async {
    final bool result = await sharedPreferences.setString(
        LOGIN_RESPONSE_PREFERENCE, jsonEncode(loginResponseModel.toJson()));
    if(!result) {
      throw CacheException();
    }
  }
}
