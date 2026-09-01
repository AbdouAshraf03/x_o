import 'package:flutter/material.dart';
import 'package:x_o/core/utils/extensions.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/typography.dart';

class TurnStatusBanner extends StatefulWidget {
  final String text;
  final Color color;

  const TurnStatusBanner({
    super.key,
    required this.text,
    this.color = AppColors.coreCyan,
  });

  @override
  State<TurnStatusBanner> createState() => _TurnStatusBannerState();
}

class _TurnStatusBannerState extends State<TurnStatusBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _pulse = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedBuilder(
          animation: _pulse,
          builder: (context, _) {
            return Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withOp(_pulse.value),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOp(_pulse.value * 0.6),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(width: 8),
        Text(
          widget.text.toUpperCase(),
          style: AppTypography.overline.copyWith(color: widget.color),
        ),
      ],
    );
  }
}
