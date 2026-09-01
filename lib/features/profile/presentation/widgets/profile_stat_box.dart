import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/typography.dart';

/// One of the three small stat boxes: Victories / Defeats /
/// Stalemates. Reuses theme tokens only.
class ProfileStatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;

  const ProfileStatBox({
    super.key,
    required this.value,
    required this.label,
    this.valueColor = AppColors.primaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.glassPanelSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: AppTypography.h3.copyWith(color: valueColor),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: AppTypography.overline.copyWith(
              color: AppColors.lowContrastText,
            ),
          ),
        ],
      ),
    );
  }
}
