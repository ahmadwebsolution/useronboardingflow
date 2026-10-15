import 'package:flutter/foundation.dart';
import '../data/services/storage_service.dart';

class HomeViewModel extends ChangeNotifier {
  final StorageService storageService;

  HomeViewModel({required this.storageService});

  bool _isOnboardingCompleted = true;
  bool get isOnboardingCompleted => _isOnboardingCompleted;

  bool _isResetting = false;
  bool get isResetting => _isResetting;

  Future<void> checkStatus() async {
    _isOnboardingCompleted = await storageService.isOnboardingCompleted();
    notifyListeners();
  }

  /// Clears the onboarding key from SharedPreferences for rapid FTUE testing
  Future<bool> resetOnboarding() async {
    _isResetting = true;
    notifyListeners();

    try {
      await storageService.clearOnboarding();
      _isOnboardingCompleted = false;
      return true;
    } catch (_) {
      return false;
    } finally {
      _isResetting = false;
      notifyListeners();
    }
  }
}
