import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/typography.dart';

class GameHeader extends StatelessWidget {
  final String playerXName;
  final String? playerXAvatarUrl;
  final String playerOName;
  final String? playerOAvatarUrl;
  final int scoreX;
  final int scoreO;

  const GameHeader({
    super.key,
    required this.playerXName,
    this.playerXAvatarUrl,
    required this.playerOName,
    this.playerOAvatarUrl,
    required this.scoreX,
    required this.scoreO,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PlayerBadge(
          name: playerXName,
          symbol: 'X',
          avatarUrl: playerXAvatarUrl,
          color: AppColors.coreCyan,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                '${scoreX.toString().padLeft(2, '0')} - ${scoreO.toString().padLeft(2, '0')}',
                style: AppTypography.h3.copyWith(color: AppColors.primaryText),
              ),
              const SizedBox(height: 2),
              Text(
                'MATCH SCORE',
                style: AppTypography.overline.copyWith(
                  color: AppColors.lowContrastText,
                ),
              ),
            ],
          ),
        ),
        _PlayerBadge(
          name: playerOName,
          symbol: 'O',
          avatarUrl: playerOAvatarUrl,
          color: AppColors.actionBlue,
          reversed: true,
        ),
      ],
    );
  }
}

class _PlayerBadge extends StatelessWidget {
  final String name;
  final String symbol;
  final String? avatarUrl;
  final Color color;
  final bool reversed;

  const _PlayerBadge({
    required this.name,
    required this.symbol,
    required this.avatarUrl,
    required this.color,
    this.reversed = false,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.5),
      ),
      child: ClipOval(
        child: avatarUrl != null
            ? Image.network(avatarUrl!, fit: BoxFit.cover)
            : Container(
                color: AppColors.inputBackground,
                child: Icon(Icons.person, color: color, size: 20),
              ),
      ),
    );

    final labels = Column(
      crossAxisAlignment: reversed
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name.toUpperCase(),
          style: AppTypography.labelSmall.copyWith(color: color),
        ),
        Text(
          '$symbol SYMBOL',
          style: AppTypography.caption.copyWith(
            color: AppColors.lowContrastText,
          ),
        ),
      ],
    );

    final children = reversed
        ? [labels, const SizedBox(width: 8), avatar]
        : [avatar, const SizedBox(width: 8), labels];

    return Row(mainAxisSize: MainAxisSize.min, children: children);
  }
}
