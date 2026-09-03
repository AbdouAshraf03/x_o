import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_o/features/game/presentation/bloc/game_bloc.dart';
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
  @override
  void initState() {
    context.read<GameBloc>().add(
      GameStarted(
        durationSeconds: widget.durationSeconds,
        turnStartedAt: DateTime.now(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is GameInProgress) {
          // final elapsed = DateTime.now().difference(widget.turnStartedAt);
          // final remaining = widget.durationSeconds - elapsed.inSeconds;
          // final progress = remaining / widget.durationSeconds;

          final isLow = state.remaining <= 5;
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
                    value: (state.remaining / widget.durationSeconds).clamp(
                      0.0,
                      1.0,
                    ),
                    strokeWidth: 4,
                    backgroundColor: AppColors.glassBorder,
                    color: color,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${state.remaining}',
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

          // return _buildTimerRing(context, remaining, progress);
        } else {
          return SizedBox(
            width: widget.size,
            height: widget.size,
            child: const CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 4,
              backgroundColor: AppColors.glassBorder,
              color: AppColors.coreCyan,
            ),
          );
        }
      },
    );
  }

  // Widget _buildTimerRing(
  //   BuildContext context,
  //   int remaining,
  //   double progress,
  // ) {}
}
