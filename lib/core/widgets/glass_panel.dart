import 'package:flutter/material.dart';
import '../theme/colors.dart';

class GlassPanel extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Duration widthDuration;
  final Duration fadeDuration;

  const GlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(28),
    this.widthDuration = const Duration(milliseconds: 500),
    this.fadeDuration = const Duration(milliseconds: 400),
  });

  @override
  State<GlassPanel> createState() => _GlassPanelState();
}

class _GlassPanelState extends State<GlassPanel> with TickerProviderStateMixin {
  late final AnimationController _widthController;
  late final AnimationController _fadeController;
  late final Animation<double> _widthAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _widthController = AnimationController(
      vsync: this,
      duration: widget.widthDuration,
      upperBound: 1,
      lowerBound: 0.27,
      // value: 0.5,
    );
    _fadeController = AnimationController(
      vsync: this,
      duration: widget.fadeDuration,
    );

    _widthAnimation = CurvedAnimation(
      parent: _widthController,
      curve: Curves.easeInOutCubic,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _widthController.forward().whenComplete(() {
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _widthController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final targetWidth = constraints.maxWidth;

        return AnimatedBuilder(
          animation: Listenable.merge([_widthAnimation, _fadeAnimation]),
          builder: (context, _) {
            return Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: targetWidth * _widthAnimation.value,
                child: Container(
                  padding: widget.padding,
                  decoration: BoxDecoration(
                    color: AppColors.glassPanelSurface,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.glassBorder, width: 1),
                  ),
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: widget.child,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
