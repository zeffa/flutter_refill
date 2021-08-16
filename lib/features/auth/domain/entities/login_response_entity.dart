import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String email, token, phone;
  final int userLevel, userId;

  const LoginResponse({
    required this.email,
    required this.phone,
    required this.token,
    required this.userId,
    required this.userLevel,
  });

  @override
  List<Object?> get props => [email, token, phone, userLevel, userId];
}
