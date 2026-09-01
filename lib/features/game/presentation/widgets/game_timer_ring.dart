import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/constants/app_constants.dart';

class GameTimerRing extends StatefulWidget {
  final DateTime turnStartedAt;
  final int durationSeconds;
  final double size;

  const GameTimerRing({
    super.key,
    required this.turnStartedAt,
    this.durationSeconds = AppConstants.turnDurationSeconds,
    this.size = 110,
  });

  @override
  State<GameTimerRing> createState() => _GameTimerRingState();
}

class _GameTimerRingState extends State<GameTimerRing> {
  Timer? _ticker;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = _computeRemaining();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _remaining = _computeRemaining());
    });
  }

  @override
  void didUpdateWidget(covariant GameTimerRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turnStartedAt != widget.turnStartedAt) {
      setState(() => _remaining = _computeRemaining());
    }
  }

  Duration _computeRemaining() {
    final elapsed = DateTime.now().difference(widget.turnStartedAt);
    final total = Duration(seconds: widget.durationSeconds);
    final remaining = total - elapsed;
    return remaining.isNegative ? Duration.zero : remaining;
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        _remaining.inMilliseconds /
        (widget.durationSeconds * 1000).clamp(1, double.infinity);
    final isLow = _remaining.inSeconds <= 5;
    final color = isLow ? AppColors.actionBlue : AppColors.coreCyan;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: CircularProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              strokeWidth: 4,
              backgroundColor: AppColors.glassBorder,
              color: color,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${_remaining.inSeconds}',
                style: AppTypography.h1.copyWith(
                  color: AppColors.primaryText,
                  fontSize: 34,
                ),
              ),
              Text(
                'SEC',
                style: AppTypography.overline.copyWith(
                  color: AppColors.lowContrastText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
