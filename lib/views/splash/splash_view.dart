import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../viewmodels/splash_viewmodel.dart';
import '../onboarding/widgets/lottie_or_vector_widget.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOutBack,
      ),
    );

    _animController.forward();

    // Trigger splash logic via MVVM after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startSplashSequence();
    });
  }

  Future<void> _startSplashSequence() async {
    final viewModel = context.read<SplashViewModel>();
    final targetRoute = await viewModel.determineInitialRoute();

    // Safe context usage check before navigation
    if (!mounted) return;

    // Non-stacking route replacement: user cannot go back to Splash
    Navigator.pushReplacementNamed(context, targetRoute);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Glow Ambiance
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.splashGlow,
            ),
          ),

          SafeArea(
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),

                      // Animated Brand Logo (Lottie with vector fallback)
                      const LottieOrVectorWidget(
                        assetPath: AppConstants.splashLottie,
                        fallbackIcon: Icons.all_inclusive_rounded,
                        gradientColors: [
                          AppColors.primary,
                          AppColors.secondary,
                        ],
                        size: 200,
                      ),

                      const SizedBox(height: 24),

                      // Brand Application Title with Vibrant Gradient
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            AppColors.primary,
                            Color(0xFF7C3AED),
                            AppColors.secondary,
                          ],
                        ).createShader(bounds),
                        child: const Text(
                          AppStrings.appName,
                          style: AppTextStyles.displayTitle,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Brand Tagline
                      Text(
                        AppStrings.appTagline,
                        style: AppTextStyles.slideSubtitle.copyWith(
                          fontSize: 13,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const Spacer(),

                      // Bottom Subtle Loading Indicator
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: const LinearProgressIndicator(
                                minHeight: 3.5,
                                backgroundColor: AppColors.border,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              AppStrings.splashSubtext,
                              style: AppTextStyles.slideSubtitle.copyWith(
                                fontSize: 11,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
