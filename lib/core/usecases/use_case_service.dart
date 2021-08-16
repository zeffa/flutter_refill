import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:uji/core/errors/failures.dart';

abstract class UseCaseService<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class Nothing extends Equatable {
  @override
  List<Object?> get props => [];
}
