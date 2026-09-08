import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/app/app.dart';
import 'package:example/features/settings/theme_mode_menu.dart';
import 'package:example/features/theme/theme_preview.dart';
import 'package:example/features/typography/typography_preview.dart';
import 'package:example/layout/app_shell.dart';
import 'package:example/layout/app_sidebar.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('ExampleApp Integration Tests', () {
    testWidgets('renders AppShell and AppSidebar with categories on desktop layout', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ExampleApp());
      await tester.pumpAndSettle();

      expect(find.byType(AppShell), findsOneWidget);
      expect(find.byType(AppSidebar), findsOneWidget);
      expect(find.byType(ThemeModeMenu), findsOneWidget);

      // Branding
      expect(find.text('Mechanix Widgets'), findsOneWidget);
      // Brand icon
      expect(find.byIcon(MechanixIcons.comet), findsOneWidget);

      // Sidebar Categories
      expect(find.text('OVERVIEW'), findsOneWidget);
      expect(find.text('FOUNDATIONS'), findsOneWidget);
      expect(find.text('COMPONENTS'), findsOneWidget);

      // Sidebar Items
      expect(find.text('Theme Overview'), findsOneWidget);
      expect(find.text('Typography'), findsWidgets);

      // By default, TypographyPreview is active
      expect(find.byType(TypographyPreview), findsOneWidget);
      expect(find.text('Material 3 Type Scale'), findsOneWidget);
    });

    testWidgets('switches between Typography and Theme sections via sidebar', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ExampleApp());
      await tester.pumpAndSettle();

      // Initial: TypographyPreview
      expect(find.byType(TypographyPreview), findsOneWidget);
      expect(find.byType(ThemePreview), findsNothing);

      // Click on Theme Overview in sidebar
      await tester.tap(find.text('Theme Overview'));
      await tester.pumpAndSettle();

      // Now: ThemePreview is active
      expect(find.byType(ThemePreview), findsOneWidget);
      expect(find.byType(TypographyPreview), findsNothing);
      expect(find.text('Reactive Theme State'), findsOneWidget);

      // Click on Typography in sidebar
      await tester.tap(find.widgetWithText(ListTile, 'Typography'));
      await tester.pumpAndSettle();

      // Back to TypographyPreview
      expect(find.byType(TypographyPreview), findsOneWidget);
      expect(find.byType(ThemePreview), findsNothing);
    });

    testWidgets('switches theme reactively across the whole app', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ExampleApp());
      await tester.pumpAndSettle();

      // Open Theme Mode menu
      await tester.tap(find.byTooltip('Select Theme Mode'));
      await tester.pumpAndSettle();

      // Switch to Dark
      await tester.tap(
        find.descendant(
          of: find.byType(PopupMenuItem<ThemeMode>),
          matching: find.text('Dark'),
        ),
      );
      await tester.pumpAndSettle();

      final BuildContext bodyContext = tester.element(
        find.text('Material 3 Type Scale'),
      );
      expect(MechanixTheme.of(bodyContext).mode, equals(ThemeMode.dark));
      expect(Theme.of(bodyContext).brightness, equals(Brightness.dark));

      // Open Theme Mode menu again and switch to Light
      await tester.tap(find.byTooltip('Select Theme Mode'));
      await tester.pumpAndSettle();

      await tester.tap(
        find.descendant(
          of: find.byType(PopupMenuItem<ThemeMode>),
          matching: find.text('Light'),
        ),
      );
      await tester.pumpAndSettle();

      final BuildContext lightContext = tester.element(
        find.text('Material 3 Type Scale'),
      );
      expect(MechanixTheme.of(lightContext).mode, equals(ThemeMode.light));
      expect(Theme.of(lightContext).brightness, equals(Brightness.light));
    });

    testWidgets('renders drawer on mobile screen width and supports navigation', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const ExampleApp());
      await tester.pumpAndSettle();

      // On mobile, the sidebar is inside a Drawer
      expect(find.byType(Drawer), findsNothing);

      // Open drawer using app bar button
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.byType(Drawer), findsOneWidget);
      expect(find.byType(AppSidebar), findsOneWidget);

      // Tap Theme Overview in drawer
      await tester.tap(find.text('Theme Overview'));
      await tester.pumpAndSettle();

      // Drawer closes, ThemePreview appears
      expect(find.byType(Drawer), findsNothing);
      expect(find.byType(ThemePreview), findsOneWidget);
    });
  });
}
