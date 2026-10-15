import 'dart:async';
import 'package:flutter/foundation.dart';
import '../core/constants/app_constants.dart';
import '../core/routes/app_routes.dart';
import '../data/services/storage_service.dart';

class SplashViewModel extends ChangeNotifier {
  final StorageService storageService;

  SplashViewModel({required this.storageService});

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _destinationRoute;
  String? get destinationRoute => _destinationRoute;

  /// Inspects storage and waits for the required 2-3s splash duration,
  /// then returns the target route (Onboarding vs Home).
  Future<String> determineInitialRoute() async {
    _isLoading = true;
    notifyListeners();

    // Run splash delay and storage check in parallel
    final results = await Future.wait<dynamic>([
      storageService.isOnboardingCompleted(),
      Future.delayed(
        const Duration(milliseconds: AppConstants.splashDelayMilliseconds),
      ),
    ]);

    final bool isCompleted = results[0] as bool;

    _destinationRoute = isCompleted ? AppRoutes.home : AppRoutes.onboarding;
    _isLoading = false;
    notifyListeners();

    return _destinationRoute!;
  }
}
