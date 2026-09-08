import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/features/theme/theme_preview.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('ThemePreview Widget Tests', () {
    testWidgets('renders section header, status card, color chips, and buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MechanixTheme(
          themeMode: ThemeMode.dark,
          builder: (context, theme, child) => MaterialApp(
            theme: theme.light,
            darkTheme: theme.dark,
            themeMode: theme.mode,
            home: const Scaffold(
              body: SingleChildScrollView(
                child: ThemePreview(),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify section header
      expect(find.text('Theme Overview'), findsOneWidget);

      // Verify status card elements
      expect(find.text('Reactive Theme State'), findsOneWidget);
      expect(find.text('Configured ThemeMode'), findsOneWidget);
      expect(find.text('Resolved Brightness'), findsOneWidget);
      expect(find.text('DARK'), findsNWidgets(2));

      // Verify color roles
      expect(find.text('Color Roles'), findsOneWidget);
      expect(find.text('Primary'), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);
      expect(find.text('Surface Container'), findsOneWidget);
      expect(find.text('Error'), findsOneWidget);

      // Verify interactive component buttons
      expect(find.text('Interactive Components'), findsOneWidget);
      expect(find.text('Filled Button'), findsOneWidget);
      expect(find.text('Outlined Button'), findsOneWidget);
      expect(find.text('Text Button'), findsOneWidget);
    });

    testWidgets('renders cleanly on narrow mobile viewport without overflow', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        MechanixTheme(
          builder: (context, theme, child) => MaterialApp(
            theme: theme.light,
            darkTheme: theme.dark,
            themeMode: theme.mode,
            home: const Scaffold(
              body: SingleChildScrollView(
                child: ThemePreview(),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ThemePreview), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
