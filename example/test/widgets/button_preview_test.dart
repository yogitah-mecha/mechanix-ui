import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/features/components/button_preview.dart';

void main() {
  group('ButtonPreview Widget Tests', () {
    testWidgets('renders ButtonPreview header and all section titles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ButtonPreview(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Header
      expect(find.text('Buttons'), findsOneWidget);
      expect(
        find.text('Mechanix Button Component Variants, Types, Sizes, States & Layouts'),
        findsOneWidget,
      );

      // Section Titles
      expect(find.text('Variants & Shape Types'), findsOneWidget);
      expect(find.text('Interactive States & Custom Styling'), findsOneWidget);
      expect(find.text('Button Scale & Sizes'), findsOneWidget);
      expect(find.text('Content & Composition Variations'), findsOneWidget);
      expect(find.text('Width Sizing Strategies'), findsOneWidget);
    });

    testWidgets('renders all variant & type labels', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ButtonPreview(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Filled - Square'), findsOneWidget);
      expect(find.text('Filled - Rounded'), findsOneWidget);
      expect(find.text('Outline - Square'), findsOneWidget);
      expect(find.text('Outline - Rounded'), findsOneWidget);
    });

    testWidgets('renders all button sizes scale', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ButtonPreview(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Extra Small'), findsOneWidget);
      expect(find.text('Small'), findsOneWidget);
      expect(find.text('Medium (Default)'), findsOneWidget);
      expect(find.text('Large'), findsOneWidget);
      expect(find.text('Extra Large'), findsOneWidget);
    });

    testWidgets('renders cleanly on narrow mobile viewport without overflow', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ButtonPreview(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ButtonPreview), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
