import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure(super.message);
}

class InputFailure extends Failure {
  const InputFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

class RateLimitExceededFailure extends ServerFailure {
  const RateLimitExceededFailure(super.message);
}

class NotFoundFailure extends ServerFailure {
  const NotFoundFailure(super.message);
}

class RequestCancelledFailure extends NetworkFailure {
  const RequestCancelledFailure(super.message);
}

// class DatabaseFailure extends Failure {
//   const DatabaseFailure(String message) : super(message);
// }
//
// class ThirdPartyServiceFailure extends Failure {
//   const ThirdPartyServiceFailure(String message) : super(message);
// }
//
// class AuthenticationFailure extends Failure {
//   const AuthenticationFailure(String message) : super(message);
// }
//
// class PermissionFailure extends Failure {
//   const PermissionFailure(String message) : super(message);
// }