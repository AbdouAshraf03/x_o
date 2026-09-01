import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';

class CusScan extends StatefulWidget {
  const CusScan({super.key});

  @override
  State<CusScan> createState() => _CusScanState();
}

class _CusScanState extends State<CusScan> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _position;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _position = Tween<double>(
      begin: -1.2,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _position,
      builder: (context, _) {
        return ClipRRect(
          borderRadius: .circular(16),
          child: Align(
            alignment: Alignment(0, _position.value),
            child: Container(
              height: 6,
              width: double.infinity,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.decorativeCyanCorner,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
