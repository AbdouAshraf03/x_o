import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/glass_panel.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;

  const StatCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Text(
            label.toUpperCase(),
            style: AppTypography.overline.copyWith(
              color: AppColors.lowContrastText,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTypography.h2.copyWith(color: AppColors.coreCyan),
          ),
        ],
      ),
    );
  }
}
