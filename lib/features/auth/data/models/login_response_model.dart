import 'package:uji/features/auth/domain/entities/login_response_entity.dart';

class LoginResponseModel extends LoginResponse {
  final String email, token, phone;
  final int userLevel, userId;

  LoginResponseModel(
      {required this.email,
      required this.token,
      required this.phone,
      required this.userLevel,
      required this.userId})
      : super(
            email: email,
            token: token,
            phone: phone,
            userId: userId,
            userLevel: userLevel);

  Map<String, dynamic> toJson() {
    return {
      "access_token": token,
      "phone": phone,
      "email": email,
      "id": userId,
      "user_level": userLevel,
    };
  }

  factory LoginResponseModel.fromJson(Map<String, dynamic> jsonMap) {
    return LoginResponseModel(
        email: jsonMap['email'],
        token: jsonMap['access_token'],
        phone: jsonMap['phone'],
        userLevel: jsonMap['user_level'],
        userId: jsonMap['id']);
  }

  factory LoginResponseModel.empty() => LoginResponseModel(
      email: "", token: "", phone: "", userLevel: 0, userId: 0);
}
