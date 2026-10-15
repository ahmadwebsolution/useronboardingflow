import 'package:flutter/material.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/onboarding_item.dart';
import 'lottie_or_vector_widget.dart';

class OnboardingCard extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double illustrationSize = (size.height * 0.34).clamp(220.0, 320.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Top Category Pill Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: item.accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: item.accentColor.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              item.badge,
              style: AppTextStyles.badge.copyWith(
                color: item.accentColor,
              ),
            ),
          ),

          const SizedBox(height: 28),

          // Rich Media: Lottie Animation / Vector Artwork
          LottieOrVectorWidget(
            assetPath: item.lottieAsset,
            fallbackIcon: item.fallbackIcon,
            gradientColors: item.gradientColors,
            size: illustrationSize,
          ),

          const SizedBox(height: 36),

          // Slide Heading
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.slideTitle,
          ),

          const SizedBox(height: 14),

          // Slide Subtitle
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 340),
            child: Text(
              item.subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.slideSubtitle,
            ),
          ),
        ],
      ),
    );
  }
}
