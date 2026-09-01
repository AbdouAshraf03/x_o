import 'package:flutter/material.dart';
import 'package:x_o/core/utils/extensions.dart';
import '../../../../../core/theme/colors.dart';

class SciFiBoard extends StatelessWidget {
  final List<String?> board;
  final ValueChanged<int> onCellTap;
  final List<int> highlightedIndices;
  final bool isInteractive;
  final int? previewIndex;
  final String? previewSymbol;

  const SciFiBoard({
    super.key,
    required this.board,
    required this.onCellTap,
    this.highlightedIndices = const [],
    this.isInteractive = true,
    this.previewIndex,
    this.previewSymbol,
  });

  // static const Color _oColor = Color(0xFFD946EF);

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
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final symbol = board[index];
          final isHighlighted = highlightedIndices.contains(index);
          final isPreview = previewIndex == index && symbol == null;
          final canTap = isInteractive && symbol == null;

          return _BoardCell(
            symbol: symbol,
            isHighlighted: isHighlighted,
            isPreview: isPreview,
            previewSymbol: previewSymbol,
            // oColor: _oColor,
            onTap: canTap ? () => onCellTap(index) : null,
          );
        },
      ),
    );
  }
}

class _BoardCell extends StatefulWidget {
  final String? symbol;
  final bool isHighlighted;
  final bool isPreview;

  final String? previewSymbol;
  // final Color oColor;
  final VoidCallback? onTap;
  const _BoardCell({
    required this.symbol,
    required this.isHighlighted,
    required this.isPreview,
    required this.previewSymbol,
    // required this.oColor,
    required this.onTap,
  });

  @override
  State<_BoardCell> createState() => _BoardCellState();
}

class _BoardCellState extends State<_BoardCell> {
  bool played = false;

  @override
  Widget build(BuildContext context) {
    final symbolColor = widget.symbol == 'X'
        ? AppColors.coreCyan
        : AppColors.mutedCyan;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.onTap?.call();
          setState(() {
            played = true;
          });
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: widget.isHighlighted
                ? AppColors.coreCyan.withOp(0.15)
                : AppColors.glassPanelSurface,
            borderRadius: BorderRadius.circular(10),
            border: widget.isPreview
                ? null
                : Border.all(color: AppColors.glassBorder, width: 1),
          ),

          child: Center(
            child: played
                ? Text(
                    widget.previewSymbol == 'X' ? 'X' : 'O',
                    // color: oColor.withOp(0.6),
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: widget.previewSymbol == 'X'
                          ? AppColors.coreCyan
                          : AppColors.mutedCyan.withOp(0.6),
                      shadows: [
                        Shadow(
                          color: widget.previewSymbol == 'X'
                              ? AppColors.coreCyan.withOp(0.7)
                              : AppColors.mutedCyan.withOp(0.4),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                  )
                : widget.symbol != null
                ? Text(
                    widget.symbol!,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: symbolColor,
                      shadows: [
                        Shadow(color: symbolColor.withOp(0.7), blurRadius: 16),
                      ],
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
