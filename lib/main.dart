import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_strings.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'data/services/storage_service.dart';
import 'viewmodels/splash_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = SharedPreferencesStorageService();

  runApp(
    MultiProvider(
      providers: [
        Provider<StorageService>.value(value: storageService),
        ChangeNotifierProvider<SplashViewModel>(
          create: (_) => SplashViewModel(storageService: storageService),
        ),
      ],
      child: const UserOnboardingApp(),
    ),
  );
}

class UserOnboardingApp extends StatelessWidget {
  const UserOnboardingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
