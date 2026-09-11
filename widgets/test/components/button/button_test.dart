import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixButton Widget Tests', () {
    testWidgets('renders filled, outline, and text button variants', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                MechanixButton.filled(
                  label: 'Filled Button',
                  onPressed: () {},
                ),
                MechanixButton.outline(
                  label: 'Outline Button',
                  onPressed: () {},
                ),
                MechanixButton.text(
                  label: 'Text Button',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Filled Button'), findsOneWidget);
      expect(find.text('Outline Button'), findsOneWidget);
      expect(find.text('Text Button'), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('handles tap events when enabled', (WidgetTester tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixButton.text(
              label: 'Tap Me',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      expect(tapped, isTrue);
    });

    testWidgets('respects disabled state when onPressed is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                MechanixButton.filled(
                  label: 'Disabled Filled',
                  onPressed: null,
                ),
                MechanixButton.text(
                  label: 'Disabled Text',
                  onPressed: null,
                ),
              ],
            ),
          ),
        ),
      );

      final filledButton = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(filledButton.onPressed, isNull);

      final textButton = tester.widget<TextButton>(find.byType(TextButton));
      expect(textButton.onPressed, isNull);
    });

    testWidgets('resolves correct background and foreground colors for text button states', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MechanixTheme.light,
          home: Scaffold(
            body: MechanixButton.text(
              label: 'Hover Test',
              onPressed: () {},
            ),
          ),
        ),
      );

      final textButton = tester.widget<TextButton>(find.byType(TextButton));
      final style = textButton.style!;

      // Background is transparent in all states
      expect(style.backgroundColor?.resolve({}), Colors.transparent);
      expect(style.backgroundColor?.resolve({WidgetState.hovered}), Colors.transparent);
      expect(style.backgroundColor?.resolve({WidgetState.pressed}), Colors.transparent);

      // Foreground is onSurface for normal/enabled/pressed/focused, onSecondaryContainer for hovered
      final lightScheme = MechanixTheme.lightColorScheme;
      expect(style.foregroundColor?.resolve({}), lightScheme.onSurface);
      expect(style.foregroundColor?.resolve({WidgetState.pressed}), lightScheme.onSurface);
      expect(style.foregroundColor?.resolve({WidgetState.focused}), lightScheme.onSurface);
      expect(style.foregroundColor?.resolve({WidgetState.hovered}), lightScheme.onSecondaryContainer);
    });
  });
}
