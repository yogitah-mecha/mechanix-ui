import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixCircularProgressIndicator Tests', () {
    testWidgets('renders standard circular indicator with default specs (40x40, 4px stroke)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixCircularProgressIndicator(value: 0.5),
            ),
          ),
        ),
      );

      final sizedBoxFinder = find.byType(SizedBox);
      expect(sizedBoxFinder, findsOneWidget);

      final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
      expect(sizedBox.width, 40.0);
      expect(sizedBox.height, 40.0);

      final circularFinder = find.byType(CircularProgressIndicator);
      expect(circularFinder, findsOneWidget);

      final indicator = tester.widget<CircularProgressIndicator>(circularFinder);
      expect(indicator.value, 0.5);
      expect(indicator.strokeWidth, 4.0);
      expect(indicator.strokeCap, StrokeCap.round);
      expect(indicator.backgroundColor, MechanixColors.darkColorScheme.secondaryContainer);
      expect(indicator.color, MechanixColors.darkColorScheme.primary);
    });

    testWidgets('renders large circular indicator with 44x44 dimension and 8px stroke', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixCircularProgressIndicator.large(value: 0.75),
            ),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.width, 44.0);
      expect(sizedBox.height, 44.0);

      final indicator =
          tester.widget<CircularProgressIndicator>(find.byType(CircularProgressIndicator));
      expect(indicator.value, 0.75);
      expect(indicator.strokeWidth, 8.0);
      expect(indicator.strokeCap, StrokeCap.round);
      expect(indicator.backgroundColor, MechanixColors.darkColorScheme.secondaryContainer);
      expect(indicator.color, MechanixColors.darkColorScheme.primary);
    });

    testWidgets('supports indeterminate circular progress indicator', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixCircularProgressIndicator(),
            ),
          ),
        ),
      );

      final indicator =
          tester.widget<CircularProgressIndicator>(find.byType(CircularProgressIndicator));
      expect(indicator.value, isNull);
    });

    testWidgets('respects explicit property overrides (custom size, colors, strokeCap)', (
      WidgetTester tester,
    ) async {
      const customColor = Colors.green;
      const customTrack = Colors.yellow;

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixCircularProgressIndicator(
                value: 0.3,
                width: 60.0,
                height: 60.0,
                strokeWidth: 6.0,
                strokeCap: StrokeCap.square,
                color: customColor,
                backgroundColor: customTrack,
                semanticsLabel: 'Downloading',
                semanticsValue: '30%',
              ),
            ),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.width, 60.0);
      expect(sizedBox.height, 60.0);

      final indicator =
          tester.widget<CircularProgressIndicator>(find.byType(CircularProgressIndicator));
      expect(indicator.strokeWidth, 6.0);
      expect(indicator.strokeCap, StrokeCap.square);
      expect(indicator.color, customColor);
      expect(indicator.backgroundColor, customTrack);
      expect(indicator.semanticsLabel, 'Downloading');
      expect(indicator.semanticsValue, '30%');
    });

    testWidgets('inherits styles from MechanixProgressIndicatorTheme', (
      WidgetTester tester,
    ) async {
      const customTheme = ProgressIndicatorThemeDataConfig(
        circularProgressColor: Colors.purple,
        circularTrackColor: Colors.white,
        standardCircularSize: 50.0,
        standardCircularStrokeWidth: 5.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixProgressIndicatorTheme(
              data: customTheme,
              child: const Center(
                child: MechanixCircularProgressIndicator(value: 0.4),
              ),
            ),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.width, 50.0);
      expect(sizedBox.height, 50.0);

      final indicator =
          tester.widget<CircularProgressIndicator>(find.byType(CircularProgressIndicator));
      expect(indicator.strokeWidth, 5.0);
      expect(indicator.color, Colors.purple);
      expect(indicator.backgroundColor, Colors.white);
    });
  });

  group('MechanixLinearProgressIndicator Tests', () {
    testWidgets('renders standard linear indicator with 4px height and capsule radius', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixLinearProgressIndicator(value: 0.5),
            ),
          ),
        ),
      );

      final indicator =
          tester.widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator));
      expect(indicator.value, 0.5);
      expect(indicator.minHeight, 4.0);
      expect(indicator.borderRadius, BorderRadius.circular(2.0));
      expect(indicator.backgroundColor, MechanixColors.darkColorScheme.secondaryContainer);
      expect(indicator.color, MechanixColors.darkColorScheme.onSurfaceVariant);
    });

    testWidgets('renders large linear indicator with 8px height and capsule radius', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixLinearProgressIndicator.large(value: 0.8),
            ),
          ),
        ),
      );

      final indicator =
          tester.widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator));
      expect(indicator.value, 0.8);
      expect(indicator.minHeight, 8.0);
      expect(indicator.borderRadius, BorderRadius.circular(4.0));
      expect(indicator.backgroundColor, MechanixColors.darkColorScheme.secondaryContainer);
      expect(indicator.color, MechanixColors.darkColorScheme.onSurfaceVariant);
    });

    testWidgets('supports indeterminate linear progress indicator', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixLinearProgressIndicator(),
            ),
          ),
        ),
      );

      final indicator =
          tester.widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator));
      expect(indicator.value, isNull);
    });

    testWidgets('respects explicit property overrides for linear indicator', (
      WidgetTester tester,
    ) async {
      const customColor = Colors.cyan;
      const customTrack = Colors.brown;
      const customRadius = BorderRadius.all(Radius.circular(12.0));

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: Center(
              child: MechanixLinearProgressIndicator(
                value: 0.6,
                minHeight: 12.0,
                borderRadius: customRadius,
                color: customColor,
                backgroundColor: customTrack,
                semanticsLabel: 'Upload',
                semanticsValue: '60%',
              ),
            ),
          ),
        ),
      );

      final indicator =
          tester.widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator));
      expect(indicator.minHeight, 12.0);
      expect(indicator.borderRadius, customRadius);
      expect(indicator.color, customColor);
      expect(indicator.backgroundColor, customTrack);
      expect(indicator.semanticsLabel, 'Upload');
      expect(indicator.semanticsValue, '60%');
    });

    testWidgets('inherits linear styles from MechanixProgressIndicatorTheme', (
      WidgetTester tester,
    ) async {
      const customTheme = ProgressIndicatorThemeDataConfig(
        linearProgressColor: Colors.teal,
        linearTrackColor: Colors.grey,
        standardLinearHeight: 6.0,
        linearBorderRadius: BorderRadius.all(Radius.circular(3.0)),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixProgressIndicatorTheme(
              data: customTheme,
              child: const Center(
                child: MechanixLinearProgressIndicator(value: 0.2),
              ),
            ),
          ),
        ),
      );

      final indicator =
          tester.widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator));
      expect(indicator.minHeight, 6.0);
      expect(indicator.borderRadius, const BorderRadius.all(Radius.circular(3.0)));
      expect(indicator.color, Colors.teal);
      expect(indicator.backgroundColor, Colors.grey);
    });
  });

  group('ProgressIndicatorThemeDataConfig Tests', () {
    test('supports copyWith, merge, and equality', () {
      const config1 = ProgressIndicatorThemeDataConfig(
        standardCircularSize: 40.0,
        circularProgressColor: Colors.red,
      );

      final config2 = config1.copyWith(
        standardCircularSize: 48.0,
      );
      expect(config2.standardCircularSize, 48.0);
      expect(config2.circularProgressColor, Colors.red);

      const mergeFrom = ProgressIndicatorThemeDataConfig(
        largeCircularSize: 52.0,
      );
      final merged = config2.merge(mergeFrom);
      expect(merged.largeCircularSize, 52.0);
      expect(merged.standardCircularSize, 48.0);

      expect(config1 == config1.copyWith(), isTrue);
      expect(config1.hashCode == config1.copyWith().hashCode, isTrue);
    });

    test('supports lerp interpolation', () {
      const a = ProgressIndicatorThemeDataConfig(
        standardCircularSize: 40.0,
        largeCircularSize: 44.0,
        standardLinearHeight: 4.0,
        largeLinearHeight: 8.0,
      );
      const b = ProgressIndicatorThemeDataConfig(
        standardCircularSize: 60.0,
        largeCircularSize: 64.0,
        standardLinearHeight: 8.0,
        largeLinearHeight: 16.0,
      );

      final lerped = a.lerp(b, 0.5);
      expect(lerped.standardCircularSize, 50.0);
      expect(lerped.largeCircularSize, 54.0);
      expect(lerped.standardLinearHeight, 6.0);
      expect(lerped.largeLinearHeight, 12.0);
    });
  });
}
