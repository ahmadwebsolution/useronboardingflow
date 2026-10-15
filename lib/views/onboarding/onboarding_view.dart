import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../data/services/storage_service.dart';
import '../../viewmodels/onboarding_viewmodel.dart';
import 'widgets/onboarding_card.dart';
import 'widgets/onboarding_nav_button.dart';
import 'widgets/page_indicator.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnboardingViewModel>(
      create: (ctx) => OnboardingViewModel(
        storageService: ctx.read<StorageService>(),
      ),
      child: const _OnboardingViewContent(),
    );
  }
}

class _OnboardingViewContent extends StatelessWidget {
  const _OnboardingViewContent();

  Future<void> _handleSkip(BuildContext context) async {
    final viewModel = context.read<OnboardingViewModel>();
    await viewModel.skip();

    if (!context.mounted) return;

    // Route replacement to Home Screen so user cannot navigate back
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  Future<void> _handleGetStarted(BuildContext context) async {
    final viewModel = context.read<OnboardingViewModel>();
    await viewModel.completeOnboarding();

    if (!context.mounted) return;

    // Route replacement to Home Screen so user cannot navigate back
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OnboardingViewModel>();
    final currentItem = viewModel.items[viewModel.currentPage];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar with Branding and "Skip" Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // App Brand Minimalist Pill
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: currentItem.gradientColors,
                          ),
                        ),
                        child: const Icon(
                          Icons.all_inclusive_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        AppStrings.appName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),

                  // Top-Right "Skip" Button (Only visible on slides before last)
                  AnimatedOpacity(
                    opacity: viewModel.isLastPage ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 250),
                    child: IgnorePointer(
                      ignoring: viewModel.isLastPage,
                      child: TextButton(
                        onPressed: () => _handleSkip(context),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.textSecondary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppStrings.skip,
                              style: AppTextStyles.textButton,
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 18,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Middle 3-Page Swipeable View
            Expanded(
              child: PageView.builder(
                controller: viewModel.pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: viewModel.items.length,
                onPageChanged: viewModel.onPageChanged,
                itemBuilder: (context, index) {
                  return OnboardingCard(item: viewModel.items[index]);
                },
              ),
            ),

            // Bottom Navigation Area
            Padding(
              padding: const EdgeInsets.fromLTRB(28.0, 16.0, 28.0, 28.0),
              child: viewModel.isLastPage
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Dynamic Page Indicator
                        PageIndicator(
                          pageCount: viewModel.items.length,
                          currentIndex: viewModel.currentPage,
                          activeColor: currentItem.accentColor,
                        ),
                        const SizedBox(height: 24),
                        // Prominent Get Started Button
                        SizedBox(
                          width: double.infinity,
                          child: OnboardingNavButton(
                            isLastPage: true,
                            onNext: viewModel.nextPage,
                            onGetStarted: () => _handleGetStarted(context),
                            gradientColors: currentItem.gradientColors,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Dynamic Page Indicator
                        PageIndicator(
                          pageCount: viewModel.items.length,
                          currentIndex: viewModel.currentPage,
                          activeColor: currentItem.accentColor,
                        ),

                        // "Next" Button
                        OnboardingNavButton(
                          isLastPage: false,
                          onNext: viewModel.nextPage,
                          onGetStarted: () => _handleGetStarted(context),
                          gradientColors: currentItem.gradientColors,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
