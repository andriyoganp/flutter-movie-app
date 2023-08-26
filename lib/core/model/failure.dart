import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({this.message = ''});

  final String message;

  @override
  List<Object?> get props => <Object>[];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message});

  @override
  List<Object?> get props => <Object>[message];
}

class CacheFailure extends Failure {
  const CacheFailure({super.message});

  @override
  List<Object?> get props => <Object>[];
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({super.message});

  @override
  List<Object?> get props => <Object>[];
}
