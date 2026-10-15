import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieOrVectorWidget extends StatefulWidget {
  final String assetPath;
  final IconData fallbackIcon;
  final List<Color> gradientColors;
  final double size;

  const LottieOrVectorWidget({
    super.key,
    required this.assetPath,
    required this.fallbackIcon,
    required this.gradientColors,
    this.size = 260,
  });

  @override
  State<LottieOrVectorWidget> createState() => _LottieOrVectorWidgetState();
}

class _LottieOrVectorWidgetState extends State<LottieOrVectorWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOutSine),
    );

    _rotationAnimation = Tween<double>(begin: -0.03, end: 0.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer Glow Ambient Circle
                  Container(
                    width: widget.size * 0.9,
                    height: widget.size * 0.9,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          widget.gradientColors.first.withValues(alpha: 0.35),
                          widget.gradientColors.last.withValues(alpha: 0.08),
                          Colors.transparent,
                        ],
                        stops: const [0.2, 0.65, 1.0],
                      ),
                    ),
                  ),

                  // Lottie Layer with graceful fallback to vector art
                  Lottie.asset(
                    widget.assetPath,
                    width: widget.size * 0.85,
                    height: widget.size * 0.85,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildFallbackVector();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFallbackVector() {
    return Container(
      width: widget.size * 0.72,
      height: widget.size * 0.72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.gradientColors.first.withValues(alpha: 0.4),
            blurRadius: 32,
            spreadRadius: 4,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          widget.fallbackIcon,
          size: widget.size * 0.35,
          color: Colors.white,
        ),
      ),
    );
  }
}
