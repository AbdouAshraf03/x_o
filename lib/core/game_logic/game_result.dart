import 'package:equatable/equatable.dart';

import 'symbol_enum.dart';

enum GameStatus { ongoing, win, draw }

class GameResult extends Equatable {
  final GameStatus status;

  final List<int> winningLine;

  final XOSymbol? winnerSymbol;

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

  const GameResult.win(XOSymbol symbol, List<int> line)
    : status = GameStatus.win,
      winnerSymbol = symbol,
      winningLine = line;

  bool get isGameOver => status != GameStatus.ongoing;

  @override
  List<Object?> get props => [status, winningLine, winnerSymbol];
}
