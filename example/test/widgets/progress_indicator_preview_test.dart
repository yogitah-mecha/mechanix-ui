import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/features/components/progress_indicator_preview.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('ProgressIndicatorPreview Widget Tests', () {
    testWidgets('renders ProgressIndicatorPreview header and sections', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: SingleChildScrollView(
              child: ProgressIndicatorPreview(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      // Header
      expect(find.text('Progress Indicators'), findsOneWidget);

      // Section titles
      expect(find.text('Interactive Playground'), findsOneWidget);
      expect(find.text('Linear - Determinate'), findsOneWidget);
      expect(find.text('Linear - Indeterminate'), findsOneWidget);
      expect(find.text('Circular - Determinate'), findsOneWidget);
      expect(find.text('Circular - Indeterminate'), findsOneWidget);
      expect(find.text('Building Blocks & Customization'), findsOneWidget);
    });

    testWidgets('contains both MechanixLinearProgressIndicator and MechanixCircularProgressIndicator', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: SingleChildScrollView(
              child: ProgressIndicatorPreview(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(MechanixLinearProgressIndicator), findsWidgets);
      expect(find.byType(MechanixCircularProgressIndicator), findsWidgets);
    });

    testWidgets('adjusts interactive slider value', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: SingleChildScrollView(
              child: ProgressIndicatorPreview(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('65%'), findsOneWidget);

      final sliderFinder = find.byType(Slider);
      expect(sliderFinder, findsOneWidget);

      // Drag slider
      await tester.drag(sliderFinder, const Offset(50, 0));
      await tester.pump(const Duration(milliseconds: 100));

      expect(tester.takeException(), isNull);
    });

    testWidgets('renders on narrow mobile viewport without exceptions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.dark,
          home: const Scaffold(
            body: SingleChildScrollView(
              child: ProgressIndicatorPreview(),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(ProgressIndicatorPreview), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
