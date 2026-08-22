class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'Server error occurred.']);
}

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
}

class RoomFullException implements Exception {
  final String message;
  const RoomFullException([this.message = 'This room is already full.']);
}

class RoomNotFoundException implements Exception {
  final String message;
  const RoomNotFoundException([this.message = 'Room not found.']);
}

class InvalidMoveException implements Exception {
  final String message;
  const InvalidMoveException([this.message = 'Invalid move.']);
}

class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Local cache error.']);
}
