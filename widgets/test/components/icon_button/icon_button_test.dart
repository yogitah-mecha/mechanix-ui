import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixIconButton Widget Tests', () {
    testWidgets('renders all 4 icon button variants', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                MechanixIconButton.filled(icon: Icons.add, onPressed: () {}),
                MechanixIconButton.tonal(icon: Icons.edit, onPressed: () {}),
                MechanixIconButton.outline(
                  icon: Icons.delete,
                  onPressed: () {},
                ),
                MechanixIconButton.standard(
                  icon: Icons.share,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
      expect(find.byIcon(Icons.share), findsOneWidget);
    });

    testWidgets('verifies icon sizes and dimensions across scale sizes', (
      WidgetTester tester,
    ) async {
      final specs = [
        (IconButtonSize.xSmall, 32.0, 20.0),
        (IconButtonSize.small, 40.0, 24.0),
        (IconButtonSize.medium, 56.0, 24.0),
        (IconButtonSize.large, 72.0, 30.86),
        (IconButtonSize.xLarge, 96.0, 32.0),
        (IconButtonSize.twoXLarge, 136.0, 40.0),
      ];

      for (final spec in specs) {
        final sizeEnum = spec.$1;
        final expectedDim = spec.$2;
        final expectedIconSize = spec.$3;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: MechanixIconButton(
                  size: sizeEnum,
                  icon: Icons.star,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        final sizedBoxFinder = find
            .ancestor(
              of: find.byIcon(Icons.star),
              matching: find.byType(SizedBox),
            )
            .first;
        final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
        expect(sizedBox.width, equals(expectedDim));
        expect(sizedBox.height, equals(expectedDim));

        final iconWidget = tester.widget<Icon>(find.byIcon(Icons.star));
        expect(iconWidget.size, equals(expectedIconSize));
      }
    });

    testWidgets('enforces minimum 48x48 tap target on xSmall and small sizes', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                MechanixIconButton(
                  size: IconButtonSize.xSmall,
                  icon: Icons.check,
                  onPressed: () {},
                ),
                MechanixIconButton(
                  size: IconButtonSize.small,
                  icon: Icons.close,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      final checkConstrainedBox = tester.widget<ConstrainedBox>(
        find
            .ancestor(
              of: find.byIcon(Icons.check),
              matching: find.byType(ConstrainedBox),
            )
            .last,
      );
      expect(checkConstrainedBox.constraints.minWidth, equals(48.0));
      expect(checkConstrainedBox.constraints.minHeight, equals(48.0));

      final closeConstrainedBox = tester.widget<ConstrainedBox>(
        find
            .ancestor(
              of: find.byIcon(Icons.close),
              matching: find.byType(ConstrainedBox),
            )
            .last,
      );
      expect(closeConstrainedBox.constraints.minWidth, equals(48.0));
      expect(closeConstrainedBox.constraints.minHeight, equals(48.0));
    });

    testWidgets('handles tap and long press events when enabled', (
      WidgetTester tester,
    ) async {
      var tapped = false;
      var longPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixIconButton(
              icon: Icons.thumb_up,
              onPressed: () => tapped = true,
              onLongPress: () => longPressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.thumb_up));
      expect(tapped, isTrue);

      await tester.longPress(find.byIcon(Icons.thumb_up));
      expect(longPressed, isTrue);
    });

    testWidgets('respects disabled state when onPressed is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MechanixIconButton(icon: Icons.block, onPressed: null),
          ),
        ),
      );

      final button = tester.widget<IconButton>(find.byType(IconButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('resolves focused border for all variants when focused', (
      WidgetTester tester,
    ) async {
      final focusNode = FocusNode();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixIconButton.filled(
              icon: Icons.star,
              focusNode: focusNode,
              autofocus: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      final iconButton = tester.widget<IconButton>(find.byType(IconButton));
      final side = iconButton.style?.side?.resolve({WidgetState.focused});
      expect(side, isNotNull);
      expect(side?.width, equals(3.0));
    });

    testWidgets('standard icon button has no border by default and 3px border only when focused', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixIconButton.standard(
              icon: Icons.star,
              onPressed: () {},
            ),
          ),
        ),
      );

      final iconButton = tester.widget<IconButton>(find.byType(IconButton));
      final defaultSide = iconButton.style?.side?.resolve({});
      final focusedSide = iconButton.style?.side?.resolve({WidgetState.focused});

      expect(defaultSide, isNull);
      expect(focusedSide, isNotNull);
      expect(focusedSide?.width, equals(3.0));
    });

    testWidgets('verifies 48x48 min tap target for xSmall icon button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixIconButton(
              size: IconButtonSize.xSmall, // 32x32 visual
              icon: Icons.check,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Find the outer ConstrainedBox wrapping the MechanixIconButton
      final constrainedBox = tester.widget<ConstrainedBox>(
        find
            .ancestor(
              of: find.byIcon(Icons.check),
              matching: find.byType(ConstrainedBox),
            )
            .last,
      );

      // Verify the tap target constraints are at least 48x48
      expect(constrainedBox.constraints.minWidth, equals(48.0));
      expect(constrainedBox.constraints.minHeight, equals(48.0));
    });

    testWidgets('verifies 48x48 min tap target for small icon button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MechanixIconButton(
              size: IconButtonSize.small, // 40X40 visual
              icon: Icons.check,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Find the outer ConstrainedBox wrapping the button
      final constrainedBox = tester.widget<ConstrainedBox>(
        find
            .ancestor(
              of: find.byIcon(Icons.check),
              matching: find.byType(ConstrainedBox),
            )
            .last,
      );

      // Verify the tap target constraints are at least 48x48
      expect(constrainedBox.constraints.minWidth, equals(48.0));
      expect(constrainedBox.constraints.minHeight, equals(48.0));
    });
  });
}
