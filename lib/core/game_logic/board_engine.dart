import 'game_result.dart';
import 'symbol_enum.dart';

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

  static bool isValidMove(List<XOSymbol?> board, int index) =>
      (index < 0 || index >= board.length) ? false : board[index] == null;

  static List<int> availableMoves(List<XOSymbol?> board) => [
    for (int i = 0; i < board.length; i++)
      if (board[i] == null) i,
  ];

  static List<XOSymbol?> applyMove(
    List<XOSymbol?> board,
    int index,
    XOSymbol symbol,
  ) {
    final next = List<XOSymbol?>.from(board);
    next[index] = symbol;
    return next;
  }

  static GameResult evaluate(List<XOSymbol?> board) {
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

  static XOSymbol opponentOf(XOSymbol symbol) => symbol == .X ? .O : .X;

  static List<XOSymbol?> emptyBoard() => List<XOSymbol?>.filled(9, null);
}
