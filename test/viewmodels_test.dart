import 'package:flutter_test/flutter_test.dart';
import 'package:useronboardingflow/core/routes/app_routes.dart';
import 'package:useronboardingflow/data/services/storage_service.dart';
import 'package:useronboardingflow/viewmodels/home_viewmodel.dart';
import 'package:useronboardingflow/viewmodels/onboarding_viewmodel.dart';
import 'package:useronboardingflow/viewmodels/splash_viewmodel.dart';

class MockStorageService implements StorageService {
  bool _isCompleted = false;

  MockStorageService({bool initialCompleted = false})
      : _isCompleted = initialCompleted;

  @override
  Future<bool> isOnboardingCompleted() async => _isCompleted;

  @override
  Future<void> setOnboardingCompleted(bool completed) async {
    _isCompleted = completed;
  }

  @override
  Future<void> clearOnboarding() async {
    _isCompleted = false;
  }
}

void main() {
  group('SplashViewModel MVVM Tests', () {
    test('routes to Onboarding when user is launching for first time', () async {
      final mockStorage = MockStorageService(initialCompleted: false);
      final splashVM = SplashViewModel(storageService: mockStorage);

      final route = await splashVM.determineInitialRoute();
      expect(route, AppRoutes.onboarding);
      expect(splashVM.destinationRoute, AppRoutes.onboarding);
      expect(splashVM.isLoading, isFalse);
    });

    test('routes directly to Home when user already completed onboarding', () async {
      final mockStorage = MockStorageService(initialCompleted: true);
      final splashVM = SplashViewModel(storageService: mockStorage);

      final route = await splashVM.determineInitialRoute();
      expect(route, AppRoutes.home);
      expect(splashVM.destinationRoute, AppRoutes.home);
      expect(splashVM.isLoading, isFalse);
    });
  });

  group('OnboardingViewModel MVVM Tests', () {
    test('initial state has 3 slides and starts at page 0', () {
      final mockStorage = MockStorageService();
      final onboardingVM = OnboardingViewModel(storageService: mockStorage);

      expect(onboardingVM.items.length, 3);
      expect(onboardingVM.currentPage, 0);
      expect(onboardingVM.isLastPage, isFalse);
    });

    test('onPageChanged updates page index and reflects isLastPage properly', () {
      final mockStorage = MockStorageService();
      final onboardingVM = OnboardingViewModel(storageService: mockStorage);

      onboardingVM.onPageChanged(1);
      expect(onboardingVM.currentPage, 1);
      expect(onboardingVM.isLastPage, isFalse);

      onboardingVM.onPageChanged(2);
      expect(onboardingVM.currentPage, 2);
      expect(onboardingVM.isLastPage, isTrue);
    });

    test('skip sets onboarding completed in storage', () async {
      final mockStorage = MockStorageService();
      final onboardingVM = OnboardingViewModel(storageService: mockStorage);

      await onboardingVM.skip();
      expect(await mockStorage.isOnboardingCompleted(), isTrue);
    });

    test('completeOnboarding sets onboarding completed in storage', () async {
      final mockStorage = MockStorageService();
      final onboardingVM = OnboardingViewModel(storageService: mockStorage);

      await onboardingVM.completeOnboarding();
      expect(await mockStorage.isOnboardingCompleted(), isTrue);
    });
  });

  group('HomeViewModel MVVM Tests', () {
    test('resetOnboarding clears onboarding key from storage', () async {
      final mockStorage = MockStorageService(initialCompleted: true);
      final homeVM = HomeViewModel(storageService: mockStorage);

      await homeVM.checkStatus();
      expect(homeVM.isOnboardingCompleted, isTrue);

      final success = await homeVM.resetOnboarding();
      expect(success, isTrue);
      expect(homeVM.isOnboardingCompleted, isFalse);
      expect(await mockStorage.isOnboardingCompleted(), isFalse);
    });
  });
}
