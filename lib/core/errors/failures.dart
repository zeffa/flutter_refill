import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties = const [];

  Failure([properties]);

  @override
  List<Object?> get props => [properties];
}

class CacheFailure extends Failure {}

class LoginFailure extends Failure {
  final String message;

  LoginFailure(this.message);
}
