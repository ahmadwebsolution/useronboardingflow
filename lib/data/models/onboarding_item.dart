import 'package:flutter/material.dart';

class OnboardingItem {
  final int id;
  final String badge;
  final String title;
  final String subtitle;
  final String lottieAsset;
  final IconData fallbackIcon;
  final List<Color> gradientColors;
  final Color accentColor;

  const OnboardingItem({
    required this.id,
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.lottieAsset,
    required this.fallbackIcon,
    required this.gradientColors,
    required this.accentColor,
  });
}
