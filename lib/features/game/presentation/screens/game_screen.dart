import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/grid_background.dart';
import '../widgets/game_header.dart';
import '../widgets/turn_status_banner.dart';
import '../widgets/game_timer_ring.dart';
import '../widgets/sci_fi_board.dart';

class GameScreen extends StatelessWidget {
  final String playerXName;
  final String? playerXAvatarUrl;
  final String playerOName;
  final String? playerOAvatarUrl;
  final int scoreX;
  final int scoreO;

  final bool isMyTurn;
  final String currentTurnSymbol;

  final DateTime turnStartedAt;
  final List<String?> board;
  final List<int> winningLine;

  final int? previewIndex;
  final String mySymbol;

  final ValueChanged<int> onCellTap;

  const GameScreen({
    super.key,
    required this.playerXName,
    this.playerXAvatarUrl,
    required this.playerOName,
    this.playerOAvatarUrl,
    required this.scoreX,
    required this.scoreO,
    required this.isMyTurn,
    required this.currentTurnSymbol,
    required this.turnStartedAt,
    required this.board,
    this.winningLine = const [],
    this.previewIndex,
    required this.mySymbol,
    required this.onCellTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridBackground(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GameHeader(
                playerXName: playerXName,
                playerXAvatarUrl: playerXAvatarUrl,
                playerOName: playerOName,
                playerOAvatarUrl: playerOAvatarUrl,
                scoreX: scoreX,
                scoreO: scoreO,
              ),
              const SizedBox(height: 20),
              TurnStatusBanner(
                text: isMyTurn
                    ? 'Your Turn // Deploying Glyph'
                    : "Opponent's Turn // Standby",
                color: isMyTurn
                    ? AppColors.coreCyan
                    : AppColors.lowContrastText,
              ),
              const SizedBox(height: 24),
              Center(child: GameTimerRing(turnStartedAt: turnStartedAt)),
              const SizedBox(height: 32),
              SciFiBoard(
                board: board,
                onCellTap: onCellTap,
                highlightedIndices: winningLine,
                isInteractive: isMyTurn,
                previewIndex: previewIndex,
                previewSymbol: mySymbol,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
