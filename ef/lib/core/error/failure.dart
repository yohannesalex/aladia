import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure()
      : super("Server error occurred. Please try again later.");
}

class ConnectionFailure extends Failure {
  const ConnectionFailure()
      : super("No internet connection. Please try again later.");
}

class InvalidUserCredentialFailure extends Failure {
  const InvalidUserCredentialFailure()
      : super("Invalid user credentials. Please try again.");
}
