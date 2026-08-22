import 'package:equatable/equatable.dart';

/// Outcome of a board evaluation.
enum GameStatus { ongoing, win, draw }

/// Result of evaluating a board: status plus (if won) the winning
/// line's cell indices, so the UI can draw a strike-through.
class GameResult extends Equatable {
  final GameStatus status;

  /// Indices (0-8) of the 3 winning cells, empty if not a win.
  final List<int> winningLine;

  /// 'X' or 'O' if status == win, otherwise null.
  final String? winnerSymbol;

  const GameResult({
    required this.status,
    this.winningLine = const [],
    this.winnerSymbol,
  });

  const GameResult.ongoing()
      : status = GameStatus.ongoing,
        winningLine = const [],
        winnerSymbol = null;

  const GameResult.draw()
      : status = GameStatus.draw,
        winningLine = const [],
        winnerSymbol = null;

  const GameResult.win(String symbol, List<int> line)
      : status = GameStatus.win,
        winnerSymbol = symbol,
        winningLine = line;

  bool get isGameOver => status != GameStatus.ongoing;

  @override
  List<Object?> get props => [status, winningLine, winnerSymbol];
}
