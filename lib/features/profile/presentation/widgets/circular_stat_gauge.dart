import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:x_o/core/utils/extensions.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/typography.dart';

class CircularStatGauge extends StatefulWidget {
  final double percentage;
  final String label;
  final String subLabel;
  final double size;

  const CircularStatGauge({
    super.key,
    required this.percentage,
    this.label = 'WIN RATE',
    this.subLabel = 'NEURAL SYNC',
    this.size = 250,
  });

  @override
  State<CircularStatGauge> createState() => _CircularStatGaugeState();
}

class _CircularStatGaugeState extends State<CircularStatGauge>
    with TickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final Animation<double> _rotation;

  late final AnimationController _progCtrl;
  late final Animation<double> _realProgressTween;

  static const Color _secondaryArcColor = AppColors.actionBlue;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
    _progCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _realProgressTween = Tween<double>(
      begin: 0,
      end: widget.percentage / 100,
    ).animate(CurvedAnimation(parent: _progCtrl, curve: Curves.easeInOut));

    _rotation = Tween<double>(begin: 0, end: math.pi * 2).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    _rotationController.repeat(/*reverse: true*/);

    _progCtrl.forward();
  }

  @override
  void didUpdateWidget(covariant CircularStatGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percentage != widget.percentage) {
      _realProgressTween = Tween<double>(
        begin: _realProgressTween.value,
        end: widget.percentage / 100,
      ).animate(CurvedAnimation(parent: _progCtrl, curve: Curves.easeInOut));
      _progCtrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _progCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'COMBAT READY',
            style: AppTypography.overline.copyWith(color: AppColors.coreCyan),
          ),
          const SizedBox(height: 8),

          ClipRect(
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: AnimatedBuilder(
                animation: Listenable.merge([_rotation, _realProgressTween]),
                builder: (context, _) {
                  return CustomPaint(
                    size: Size(widget.size, widget.size),
                    painter: _GaugePainter(
                      progress: _rotation.value,
                      primaryColor: AppColors.coreCyan,
                      secondaryColor: _secondaryArcColor,
                      trackColor: AppColors.white.withOp(0.1),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.label,
                            style: AppTypography.overline.copyWith(
                              color: AppColors.lowContrastText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${(_realProgressTween.value * 100).round()}',
                                style: AppTypography.h1.copyWith(
                                  color: AppColors.primaryText,
                                  fontSize: 44,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Text(
                                  '%',
                                  style: AppTypography.h4.copyWith(
                                    color: AppColors.coreCyan,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.subLabel,
            style: AppTypography.overline.copyWith(
              color: AppColors.lowContrastText,
            ),
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  final Color primaryColor;
  final Color secondaryColor;
  final Color trackColor;

  _GaugePainter({
    required this.progress,
    required this.primaryColor,
    required this.secondaryColor,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 2.0;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final primaryPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final secPrimaryPaint = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = size.center(Offset.zero);
    final outerRadius = math.min(size.width, size.height) / 2 - 4;
    final innerRadius = outerRadius - 25;

    final rect = Rect.fromCircle(center: center, radius: innerRadius);
    final secRect = Rect.fromCircle(center: center, radius: outerRadius);

    canvas.drawArc(rect, -math.pi, -math.pi * 2, false, trackPaint);
    canvas.drawArc(rect, math.pi + progress, math.pi, false, primaryPaint);

    canvas.drawArc(secRect, -math.pi, -math.pi * 2, false, trackPaint);
    canvas.drawArc(
      secRect,
      math.pi - progress,
      math.pi,
      false,
      secPrimaryPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
