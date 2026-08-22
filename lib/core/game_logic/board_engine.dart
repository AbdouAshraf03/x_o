import 'game_result.dart';

class BoardEngine {
  BoardEngine._();

  static const List<List<int>> _winningLines = [
    // rows
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    // columns
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    // diagonals
    [0, 4, 8],
    [2, 4, 6],
  ];

  static bool isValidMove(List<String?> board, int index) =>
      (index < 0 || index >= board.length) ? false : board[index] == null;

  static List<int> availableMoves(List<String?> board) => [
    for (int i = 0; i < board.length; i++)
      if (board[i] == null) i,
  ];

  static List<String?> applyMove(
    List<String?> board,
    int index,
    String symbol,
  ) {
    final next = List<String?>.from(board);
    next[index] = symbol;
    return next;
  }

  static GameResult evaluate(List<String?> board) {
    for (final line in _winningLines) {
      final a = board[line[0]];
      final b = board[line[1]];
      final c = board[line[2]];
      if (a != null && a == b && b == c) {
        return GameResult.win(a, line);
      }
    }

    if (!board.contains(null)) {
      return const GameResult.draw();
    }

    return const GameResult.ongoing();
  }

  static String opponentOf(String symbol) => symbol == 'X' ? 'O' : 'X';

  static List<String?> emptyBoard() => List<String?>.filled(9, null);
}
