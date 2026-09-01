import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/typography.dart';

class RoomInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const RoomInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            label.toUpperCase(),
            style: AppTypography.overline.copyWith(
              color: AppColors.lowContrastText,
            ),
          ),
          Text(
            value.toUpperCase(),
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.coreCyan,
            ),
          ),
        ],
      ),
    );
  }
}
