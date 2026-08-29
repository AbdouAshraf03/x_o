import 'package:flutter/material.dart';
import 'package:x_o/core/theme/colors.dart';

import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/grid_background.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridBackground(
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [_CustomForm()],
      ),
    );
  }
}

class _CustomForm extends StatelessWidget {
  const _CustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Container(
      width: w - (w * .7),
      height: h - (h * .7),
      decoration: BoxDecoration(
        border: BoxBorder.all(width: 1, color: AppColors.actionBlue),
      ),
      child: Align(
        alignment: .topCenter,
        child: Text(
          "X-O",
          style: AppTypography.h1.copyWith(color: AppColors.gradientEnd),
        ),
      ),
    );
  }
}
