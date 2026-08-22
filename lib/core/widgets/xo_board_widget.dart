import 'package:flutter/material.dart';

/// Dumb, reusable 3x3 board widget. Knows nothing about Firebase,
/// blocs, or game modes — it just renders [board] and reports taps.
/// Reused by both the online [GameScreen] and offline [AiGameScreen].
class XoBoardWidget extends StatelessWidget {
  final List<String?> board;
  final ValueChanged<int> onCellTap;

  /// Cell indices to highlight (the winning line), if any.
  final List<int> highlightedIndices;

  /// Disables all taps, e.g. when it's not the player's turn or the
  /// game has ended.
  final bool isInteractive;

  const XoBoardWidget({
    super.key,
    required this.board,
    required this.onCellTap,
    this.highlightedIndices = const [],
    this.isInteractive = true,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: board.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final symbol = board[index];
          final isHighlighted = highlightedIndices.contains(index);
          final canTap = isInteractive && symbol == null;

          return _BoardCell(
            symbol: symbol,
            isHighlighted: isHighlighted,
            onTap: canTap ? () => onCellTap(index) : null,
          );
        },
      ),
    );
  }
}

class _BoardCell extends StatelessWidget {
  final String? symbol;
  final bool isHighlighted;
  final VoidCallback? onTap;

  const _BoardCell({
    required this.symbol,
    required this.isHighlighted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: isHighlighted
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Text(
            symbol ?? '',
            style: theme.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: symbol == 'X'
                  ? theme.colorScheme.primary
                  : theme.colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
