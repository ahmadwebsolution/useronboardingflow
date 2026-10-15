class AppStrings {
  AppStrings._();

  // App General
  static const String appName = 'useronboarding';
  static const String appTagline = 'Next-Generation Experience';

  // Splash Screen
  static const String splashSubtext = 'Initializing your personalized experience...';

  // Onboarding - Slide 1
  static const String slide1Badge = 'EXPLORE';
  static const String slide1Title = 'Discover Limitless Possibilities';
  static const String slide1Subtitle =
      'Supercharge your workflow with intuitive tools engineered for speed, focus, and modern performance.';

  // Onboarding - Slide 2
  static const String slide2Badge = 'SYNC & ANALYZE';
  static const String slide2Title = 'Real-Time Insights & Automation';
  static const String slide2Subtitle =
      'Track vital metrics, collaborate seamlessly, and watch your productivity reach new heights.';

  // Onboarding - Slide 3
  static const String slide3Badge = 'GET READY';
  static const String slide3Title = 'Ready For Your Next Big Leap';
  static const String slide3Subtitle =
      'Your workspace is tailored and ready. Join our forward-thinking community and start building today.';

  // Buttons & Navigation
  static const String skip = 'Skip';
  static const String next = 'Next';
  static const String getStarted = 'Get Started';

  // Home Screen
  static const String homeTitle = 'useronboarding Dashboard';
  static const String homeWelcomeHeader = 'Welcome Back!';
  static const String homeWelcomeSubtitle =
      'You have successfully completed the onboarding flow.';
  static const String homeStatusTitle = 'FTUE Status';
  static const String homeStatusActive = 'Onboarding Completed (Stored in SharedPreferences)';
  static const String homeStatusKeyName = 'Key: key_onboarding_completed = true';
  static const String resetOnboardingButton = 'Reset Onboarding';
  static const String resetDialogTitle = 'Reset Onboarding State?';
  static const String resetDialogContent =
      'This will remove the completion key from SharedPreferences and route you back to the Splash Screen for testing.';
  static const String resetConfirm = 'Yes, Reset';
  static const String cancel = 'Cancel';
  static const String resetSuccessSnackbar =
      'Onboarding reset successfully! Restarting flow...';

  // Feature Highlights in Home
  static const String feature1Title = 'MVVM Clean Architecture';
  static const String feature1Desc = 'Decoupled Models, Views, ViewModels & Services';
  static const String feature2Title = 'Persistent Storage';
  static const String feature2Desc = 'Fast & reliable state using SharedPreferences';
  static const String feature3Title = 'Fluid Animations';
  static const String feature3Desc = 'Custom PageTransitions & Lottie/Vector integrations';
}
