import 'package:flutter/material.dart';
import 'package:x_o/core/utils/extensions.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/typography.dart';

class StatusChip extends StatelessWidget {
  final String label;
  final bool isActive;

  const StatusChip({super.key, required this.label, this.isActive = true});

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.statusGreen : AppColors.lowContrastText;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOp(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOp(0.5), width: 1),
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTypography.labelSmall.copyWith(color: color),
      ),
    );
  }
}
