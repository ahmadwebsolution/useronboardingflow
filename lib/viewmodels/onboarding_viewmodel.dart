import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../data/models/onboarding_item.dart';
import '../data/services/onboarding_data.dart';
import '../data/services/storage_service.dart';

class OnboardingViewModel extends ChangeNotifier {
  final StorageService storageService;
  final PageController pageController;

  OnboardingViewModel({required this.storageService})
      : pageController = PageController();

  final List<OnboardingItem> items = OnboardingData.slides;

  int _currentPage = 0;
  int get currentPage => _currentPage;

  bool get isLastPage => _currentPage == items.length - 1;

  void onPageChanged(int index) {
    if (_currentPage != index) {
      _currentPage = index;
      notifyListeners();
    }
  }

  /// Advances PageView to the next slide with smooth curve animation
  Future<void> nextPage() async {
    if (!isLastPage && pageController.hasClients) {
      await pageController.nextPage(
        duration: AppConstants.pageTransitionDuration,
        curve: Curves.easeInOutCubic,
      );
    }
  }

  /// Flags onboarding as completed when user taps "Skip" and returns
  Future<void> skip() async {
    await storageService.setOnboardingCompleted(true);
  }

  /// Flags onboarding as completed when user taps "Get Started" on slide 3
  Future<void> completeOnboarding() async {
    await storageService.setOnboardingCompleted(true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
