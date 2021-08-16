import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String phone, password;

  const Login({required this.phone, required this.password});

  @override
  List<Object?> get props => [phone, password];

  Map<String, dynamic> toJson() => {"phone": phone, "password": password};
}
