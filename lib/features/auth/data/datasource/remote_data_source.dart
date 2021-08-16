import 'dart:convert';

import 'package:http/http.dart';
import 'package:uji/core/errors/exceptions.dart';
import 'package:uji/core/utils/constants.dart';
import 'package:uji/features/auth/data/models/login_response_model.dart';
import 'package:uji/features/auth/domain/entities/login_request.dart';

abstract class RemoteDatasource {
  Future<LoginResponseModel> loginUser(Login login);
}

class RemoteDataSourceImpl extends RemoteDatasource {
  final Client httpClient;

  RemoteDataSourceImpl({required this.httpClient});

  @override
  Future<LoginResponseModel> loginUser(Login login) async {
    final loginUrl = Uri.parse(DEVELOPMENT_BASE_URL + "auth/login");
    final Response response =
        await httpClient.post(loginUrl, body: login.toJson());
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    }
    throw ServerException(
        message: jsonDecode(response.body)['message'],
        code: response.statusCode);
  }
}
