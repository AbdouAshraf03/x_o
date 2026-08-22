class FirebaseCollections {
  FirebaseCollections._();

  static const String users = 'users';
  static const String rooms = 'rooms';
  static const String games = 'games';

  // Common field names
  static const String fieldOwnerId = 'ownerId';
  static const String fieldPlayers = 'players';
  static const String fieldStatus = 'status';
  static const String fieldBoard = 'board';
  static const String fieldCurrentTurn = 'currentTurn';
  static const String fieldTurnStartedAt = 'turnStartedAt';
  static const String fieldWinnerId = 'winnerId';
  static const String fieldCreatedAt = 'createdAt';
}
