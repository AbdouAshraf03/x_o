import '../board_engine.dart';
import '../game_result.dart';
import '../symbol_enum.dart';

class MinimaxStrategy {
  int pickMove(List<XOSymbol?> board, XOSymbol aiSymbol) {
    final available = BoardEngine.availableMoves(board);
    if (available.isEmpty) {
      throw StateError('No available moves to pick from.');
    }

    int bestScore = -1000;
    int bestMove = available.first;

    for (final move in available) {
      final next = BoardEngine.applyMove(board, move, aiSymbol);
      final score = _minimax(
        next,
        depth: 1,
        isMaximizing: false,
        aiSymbol: aiSymbol,
        humanSymbol: BoardEngine.opponentOf(aiSymbol),
        alpha: -1000,
        beta: 1000,
      );
      if (score > bestScore) {
        bestScore = score;
        bestMove = move;
      }
    }

    return bestMove;
  }

  int _minimax(
    List<XOSymbol?> board, {
    required int depth,
    required bool isMaximizing,
    required XOSymbol aiSymbol,
    required XOSymbol humanSymbol,
    required int alpha,
    required int beta,
  }) {
    final result = BoardEngine.evaluate(board);

    if (result.status == GameStatus.win) {
      final winnerIsAi = result.winnerSymbol == aiSymbol;
      return winnerIsAi ? (10 - depth) : (depth - 10);
    }
    if (result.status == GameStatus.draw) {
      return 0;
    }

    final available = BoardEngine.availableMoves(board);

    if (isMaximizing) {
      int best = -1000;
      for (final move in available) {
        final next = BoardEngine.applyMove(board, move, aiSymbol);
        final score = _minimax(
          next,
          depth: depth + 1,
          isMaximizing: false,
          aiSymbol: aiSymbol,
          humanSymbol: humanSymbol,
          alpha: alpha,
          beta: beta,
        );
        if (score > best) best = score;
        if (best > alpha) alpha = best;
        if (beta <= alpha) break; // prune
      }
      return best;
    } else {
      int best = 1000;
      for (final move in available) {
        final next = BoardEngine.applyMove(board, move, humanSymbol);
        final score = _minimax(
          next,
          depth: depth + 1,
          isMaximizing: true,
          aiSymbol: aiSymbol,
          humanSymbol: humanSymbol,
          alpha: alpha,
          beta: beta,
        );
        if (score < best) best = score;
        if (best < beta) beta = best;
        if (beta <= alpha) break; // prune
      }
      return best;
    }
  }
}
