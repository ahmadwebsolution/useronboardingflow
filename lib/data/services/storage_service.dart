import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

abstract class StorageService {
  /// Checks whether FTUE onboarding has already been completed by user
  Future<bool> isOnboardingCompleted();

  /// Sets the onboarding completion status in persistent storage
  Future<void> setOnboardingCompleted(bool completed);

  /// Clears the onboarding completion flag for testing and resets
  Future<void> clearOnboarding();
}

class SharedPreferencesStorageService implements StorageService {
  final SharedPreferences? _prefsInstance;

  SharedPreferencesStorageService([this._prefsInstance]);

  Future<SharedPreferences> _getPrefs() async {
    return _prefsInstance ?? await SharedPreferences.getInstance();
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    final prefs = await _getPrefs();
    return prefs.getBool(AppConstants.keyOnboardingCompleted) ?? false;
  }

  @override
  Future<void> setOnboardingCompleted(bool completed) async {
    final prefs = await _getPrefs();
    await prefs.setBool(AppConstants.keyOnboardingCompleted, completed);
  }

  @override
  Future<void> clearOnboarding() async {
    final prefs = await _getPrefs();
    await prefs.remove(AppConstants.keyOnboardingCompleted);
  }
}
