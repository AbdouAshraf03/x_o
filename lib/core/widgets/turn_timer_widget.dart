import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Circular countdown shown during a player's turn. Purely visual —
/// the actual forfeit-on-timeout logic lives server-side / in the bloc
/// (see ForfeitTurnUseCase), this widget just reflects [turnStartedAt].
class TurnTimerWidget extends StatefulWidget {
  /// When the current turn began (server timestamp from Firestore).
  final DateTime turnStartedAt;

  /// Total seconds allotted per turn.
  final int durationSeconds;

  const TurnTimerWidget({
    super.key,
    required this.turnStartedAt,
    this.durationSeconds = AppConstants.turnDurationSeconds,
  });

  @override
  State<TurnTimerWidget> createState() => _TurnTimerWidgetState();
}

class _TurnTimerWidgetState extends State<TurnTimerWidget> {
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
  void didUpdateWidget(covariant TurnTimerWidget oldWidget) {
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
    final theme = Theme.of(context);
    final progress = _remaining.inMilliseconds /
        (widget.durationSeconds * 1000).clamp(1, double.infinity);
    final isLow = _remaining.inSeconds <= 5;

    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            strokeWidth: 4,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            color: isLow ? theme.colorScheme.error : theme.colorScheme.primary,
          ),
          Text(
            '${_remaining.inSeconds}',
            style: theme.textTheme.labelLarge?.copyWith(
              color: isLow ? theme.colorScheme.error : null,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
