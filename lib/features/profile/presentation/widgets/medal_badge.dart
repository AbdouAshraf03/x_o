import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';

/// Small hexagon medal icon in the "Distinguished Medals" row.
/// Locked medals render dim with a lock icon; unlocked medals show
/// their [icon] in [color] with a glow.
class MedalBadge extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool isUnlocked;
  final double size;

  const MedalBadge({
    super.key,
    required this.icon,
    this.color = AppColors.coreCyan,
    this.isUnlocked = true,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        boxShadow: isUnlocked
            ? [
                BoxShadow(
                  color: color.withOpacity(0.35),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: CustomPaint(
        painter: _HexPainter(
          fillColor: isUnlocked
              ? color.withOpacity(0.15)
              : AppColors.glassPanelSurface,
          borderColor: isUnlocked ? color : AppColors.glassBorder,
        ),
        child: Center(
          child: Icon(
            isUnlocked ? icon : Icons.lock_outline,
            color: isUnlocked ? color : AppColors.mutedPlaceholder,
            size: size * 0.42,
          ),
        ),
      ),
    );
  }
}

class _HexPainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;

  _HexPainter({required this.fillColor, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final path = _hexPath(size);

    canvas.drawPath(path, Paint()..color = fillColor);
    canvas.drawPath(
      path,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  Path _hexPath(Size size) {
    final path = Path();
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = math.min(size.width, size.height) / 2;

    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i - math.pi / 2;
      final point = Offset(cx + r * math.cos(angle), cy + r * math.sin(angle));
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant _HexPainter oldDelegate) =>
      oldDelegate.fillColor != fillColor || oldDelegate.borderColor != borderColor;
}
