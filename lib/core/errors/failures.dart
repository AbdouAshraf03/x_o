import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Generic server / Firestore failure (network write/read errors, etc).
class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'Something went wrong. Please try again.',
  ]);
}

/// No internet connectivity.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection.']);
}

/// Authentication-specific failures (login/register).
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Attempted to join a room that already has 2 players.
class RoomFullFailure extends Failure {
  const RoomFullFailure([super.message = 'This room is already full.']);
}

/// Attempted to join/act on a room that no longer exists.
class RoomNotFoundFailure extends Failure {
  const RoomNotFoundFailure([super.message = 'Room not found.']);
}

/// Attempted an invalid move (cell taken, not your turn, game over).
class InvalidMoveFailure extends Failure {
  const InvalidMoveFailure([super.message = 'Invalid move.']);
}

/// Generic cache/local-storage failure.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Local cache error.']);
}
