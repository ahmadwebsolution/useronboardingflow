import 'package:flutter_test/flutter_test.dart';
import 'package:useronboardingflow/core/constants/app_strings.dart';
import 'package:useronboardingflow/views/onboarding/widgets/onboarding_nav_button.dart';
import 'package:useronboardingflow/views/onboarding/widgets/page_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('PageIndicator renders correct dot count', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PageIndicator(
            pageCount: 3,
            currentIndex: 0,
          ),
        ),
      ),
    );

    expect(find.byType(PageIndicator), findsOneWidget);
    expect(find.byType(AnimatedContainer), findsNWidgets(3));
  });

  testWidgets('OnboardingNavButton displays Next on slide 0 and Get Started on slide 2',
      (WidgetTester tester) async {
    bool nextCalled = false;
    bool getStartedCalled = false;

    // Test Slide 0 / 1 (Next button)
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OnboardingNavButton(
            isLastPage: false,
            onNext: () => nextCalled = true,
            onGetStarted: () => getStartedCalled = true,
            gradientColors: const [Colors.blue, Colors.purple],
          ),
        ),
      ),
    );

    expect(find.text(AppStrings.next), findsOneWidget);
    await tester.tap(find.text(AppStrings.next));
    expect(nextCalled, isTrue);

    // Test Slide 2 (Get Started button)
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OnboardingNavButton(
            isLastPage: true,
            onNext: () => nextCalled = true,
            onGetStarted: () => getStartedCalled = true,
            gradientColors: const [Colors.teal, Colors.green],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.getStarted), findsOneWidget);
    await tester.tap(find.text(AppStrings.getStarted));
    expect(getStartedCalled, isTrue);
  });
}
