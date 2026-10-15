import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../models/onboarding_item.dart';

class OnboardingData {
  OnboardingData._();

  static List<OnboardingItem> get slides => const [
        OnboardingItem(
          id: 1,
          badge: AppStrings.slide1Badge,
          title: AppStrings.slide1Title,
          subtitle: AppStrings.slide1Subtitle,
          lottieAsset: AppConstants.onboarding1Lottie,
          fallbackIcon: Icons.rocket_launch_rounded,
          gradientColors: AppColors.slide1Gradient,
          accentColor: AppColors.primary,
        ),
        OnboardingItem(
          id: 2,
          badge: AppStrings.slide2Badge,
          title: AppStrings.slide2Title,
          subtitle: AppStrings.slide2Subtitle,
          lottieAsset: AppConstants.onboarding2Lottie,
          fallbackIcon: Icons.insights_rounded,
          gradientColors: AppColors.slide2Gradient,
          accentColor: Color(0xFFEC4899),
        ),
        OnboardingItem(
          id: 3,
          badge: AppStrings.slide3Badge,
          title: AppStrings.slide3Title,
          subtitle: AppStrings.slide3Subtitle,
          lottieAsset: AppConstants.onboarding3Lottie,
          fallbackIcon: Icons.verified_rounded,
          gradientColors: AppColors.slide3Gradient,
          accentColor: AppColors.secondary,
        ),
      ];
}
