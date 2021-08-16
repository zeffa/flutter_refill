part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthUsernameChanged extends AuthEvent {
  final String _username;

  AuthUsernameChanged(this._username);

  @override
  List<Object> get props => [_username];
}

class AuthPasswordChanged extends AuthEvent {
  final String _password;

  AuthPasswordChanged(this._password);

  @override
  List<Object> get props => [_password];
}

class FormSubmit extends AuthEvent {
  @override
  List<Object> get props => [];
}
