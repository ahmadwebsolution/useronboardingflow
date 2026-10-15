class AppConstants {
  AppConstants._();

  // Storage Keys
  static const String keyOnboardingCompleted = 'key_onboarding_completed';
  static const String keyAppInstallTime = 'key_app_install_time';

  // Splash Configuration
  static const int splashDelayMilliseconds = 2500; // 2.5 seconds

  // Animation Durations
  static const Duration pageTransitionDuration = Duration(milliseconds: 400);
  static const Duration indicatorAnimationDuration = Duration(milliseconds: 300);
  static const Duration buttonMorphDuration = Duration(milliseconds: 350);

  // Asset paths
  static const String splashLottie = 'assets/animations/splash_logo.json';
  static const String onboarding1Lottie = 'assets/animations/onboarding_1.json';
  static const String onboarding2Lottie = 'assets/animations/onboarding_2.json';
  static const String onboarding3Lottie = 'assets/animations/onboarding_3.json';
}
