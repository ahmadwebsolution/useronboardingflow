import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Brand Colors (Vibrant Royal Indigo & Violet)
  static const Color primary = Color(0xFF4F46E5); // Indigo 600
  static const Color primaryDark = Color(0xFF3730A3); // Indigo 800
  static const Color primaryLight = Color(0xFF6366F1); // Indigo 500

  // Secondary Accents
  static const Color secondary = Color(0xFF06B6D4); // Vibrant Cyan
  static const Color accent = Color(0xFFF43F5E); // Electric Rose
  static const Color success = Color(0xFF10B981); // Emerald
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color purple = Color(0xFF8B5CF6); // Violet

  // Light Canvas & Surface Palette (Replaces black/dark mode)
  static const Color background = Color(0xFFF8FAFC); // Airy Slate 50
  static const Color surface = Color(0xFFFFFFFF); // Crisp Pure White
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE2E8F0); // Light Slate 200 Border
  static const Color borderFocus = Color(0xFFC7D2FE);

  // Modern Text Typography Colors
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900 (Deep Charcoal)
  static const Color textSecondary = Color(0xFF475569); // Slate 600
  static const Color textMuted = Color(0xFF94A3B8); // Slate 400

  // Slide Gradients (Fresh, Inspiring, High Contrast)
  static const List<Color> slide1Gradient = [
    Color(0xFF4F46E5),
    Color(0xFF6366F1),
  ];

  static const List<Color> slide2Gradient = [
    Color(0xFF7C3AED),
    Color(0xFFEC4899),
  ];

  static const List<Color> slide3Gradient = [
    Color(0xFF0284C7),
    Color(0xFF10B981),
  ];

  // Welcome Banner Gradient
  static const List<Color> bannerGradient = [
    Color(0xFF4F46E5),
    Color(0xFF7C3AED),
  ];

  // Splash & Ambient Glow Gradients
  static const RadialGradient splashGlow = RadialGradient(
    center: Alignment(0.0, -0.25),
    radius: 0.95,
    colors: [
      Color(0x336366F1), // Soft luminous indigo glow
      Color(0x00F8FAFC),
    ],
  );
}
