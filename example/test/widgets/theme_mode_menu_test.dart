import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/features/settings/theme_mode_menu.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('ThemeModeMenu Unit / Widget Tests', () {
    testWidgets('renders current mode label correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: ThemeModeMenu(currentMode: ThemeMode.dark),
            ),
          ),
        ),
      );

      expect(find.text('Theme Mode'), findsOneWidget);
      expect(find.text('Dark'), findsOneWidget);
    });

    testWidgets('opens popup and calls onThemeModeChanged when item is selected', (
      WidgetTester tester,
    ) async {
      ThemeMode? chosenMode;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ThemeModeMenu(
                currentMode: ThemeMode.system,
                onThemeModeChanged: (mode) => chosenMode = mode,
              ),
            ),
          ),
        ),
      );

      // Tap trigger to open popup
      await tester.tap(find.byTooltip('Select Theme Mode'));
      await tester.pumpAndSettle();

      // Verify menu structure
      expect(find.byType(PopupMenuDivider), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(PopupMenuItem<ThemeMode>),
          matching: find.text('System'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(PopupMenuItem<ThemeMode>),
          matching: find.text('Light'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(PopupMenuItem<ThemeMode>),
          matching: find.text('Dark'),
        ),
        findsOneWidget,
      );

      // Select 'Light'
      await tester.tap(
        find.descendant(
          of: find.byType(PopupMenuItem<ThemeMode>),
          matching: find.text('Light'),
        ),
      );
      await tester.pumpAndSettle();

      expect(chosenMode, equals(ThemeMode.light));
    });

    testWidgets('defaults to MechanixTheme when onThemeModeChanged is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MechanixTheme(
          builder: (context, theme, child) => MaterialApp(
            theme: theme.light,
            darkTheme: theme.dark,
            themeMode: theme.mode,
            home: const Scaffold(
              body: Center(child: ThemeModeMenu()),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Open menu and select Dark
      await tester.tap(find.byTooltip('Select Theme Mode'));
      await tester.pumpAndSettle();

      await tester.tap(
        find.descendant(
          of: find.byType(PopupMenuItem<ThemeMode>),
          matching: find.text('Dark'),
        ),
      );
      await tester.pumpAndSettle();

      final BuildContext context = tester.element(find.byType(ThemeModeMenu));
      expect(MechanixTheme.of(context).mode, equals(ThemeMode.dark));
    });
  });
}
