import 'package:flutter/material.dart';
import 'package:x_o/core/theme/colors.dart';
import 'package:x_o/core/utils/extensions.dart';

class GridBackground extends StatefulWidget {
  final Widget? child;
  final PreferredSizeWidget? appBar;
  final bool enableScanAnimation;

  const GridBackground({
    super.key,
    this.child,
    this.appBar,
    this.enableScanAnimation = true,
  });

  @override
  State<GridBackground> createState() => _GridBackgroundState();
}

class _GridBackgroundState extends State<GridBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctl;
  @override
  void initState() {
    super.initState();
    if (widget.enableScanAnimation) {
      _ctl = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
      )..repeat();
    }
  }

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: AppColors.deepSpaceDark,
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _ctl,
              builder: (context, child) {
                return CustomPaint(
                  painter: GridPainter(scanPosition: _ctl.value),
                  child: child,
                );
              },
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final double spacing = 40;
  final double scanPosition;

  GridPainter({required this.scanPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0E3B48).withOp(0.15)
      ..strokeWidth = 1.5;

    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final scanY = scanPosition * size.height;
    final scanPaint = Paint()
      ..color = AppColors.actionBlue.withOp(0.15)
      ..strokeWidth = 2;
    canvas.drawLine(Offset(0, scanY), Offset(size.width, scanY), scanPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as GridPainter).scanPosition != scanPosition;
  }
}
