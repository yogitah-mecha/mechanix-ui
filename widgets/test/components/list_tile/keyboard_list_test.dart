import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  Widget app(Widget body) => MaterialApp(
    theme: MechanixTheme.dark,
    home: Scaffold(body: body),
  );

  List<FocusNode> makeNodes(int count) {
    final nodes = List.generate(count, (i) => FocusNode(debugLabel: 'row $i'));
    addTearDown(() {
      for (final node in nodes) {
        node.dispose();
      }
    });
    return nodes;
  }

  Future<void> press(WidgetTester tester, LogicalKeyboardKey key) async {
    await tester.sendKeyEvent(key);
    await tester.pumpAndSettle();
  }

  group('MechanixKeyboardList', () {
    testWidgets('↓/↑ move between the tiles of a MechanixList', (
      WidgetTester tester,
    ) async {
      final nodes = makeNodes(3);
      await tester.pumpWidget(
        app(
          MechanixList(
            children: [
              for (var i = 0; i < 3; i++)
                MechanixListTile(
                  labelText: 'Row $i',
                  focusNode: nodes[i],
                  onTap: () {},
                ),
            ],
          ),
        ),
      );
      nodes[0].requestFocus();
      await tester.pump();

      await press(tester, LogicalKeyboardKey.arrowDown);
      expect(nodes[1].hasPrimaryFocus, isTrue);
      await press(tester, LogicalKeyboardKey.arrowDown);
      expect(nodes[2].hasPrimaryFocus, isTrue);
      await press(tester, LogicalKeyboardKey.arrowUp);
      expect(nodes[1].hasPrimaryFocus, isTrue);
    });

    testWidgets('↓ then Enter calls onTap of the reached tile', (
      WidgetTester tester,
    ) async {
      final nodes = makeNodes(2);
      final tapped = <int>[];
      await tester.pumpWidget(
        app(
          MechanixList.segmented(
            children: [
              for (var i = 0; i < 2; i++)
                MechanixListTile.segmented(
                  labelText: 'Row $i',
                  focusNode: nodes[i],
                  onTap: () => tapped.add(i),
                ),
            ],
          ),
        ),
      );
      nodes[0].requestFocus();
      await tester.pump();

      await press(tester, LogicalKeyboardKey.arrowDown);
      await press(tester, LogicalKeyboardKey.enter);

      expect(tapped, [1]);
    });

    testWidgets('disabled tiles are skipped', (WidgetTester tester) async {
      final nodes = makeNodes(3);
      await tester.pumpWidget(
        app(
          MechanixList(
            children: [
              for (var i = 0; i < 3; i++)
                MechanixListTile(
                  labelText: 'Row $i',
                  focusNode: nodes[i],
                  enabled: i != 1,
                  onTap: () {},
                ),
            ],
          ),
        ),
      );
      nodes[0].requestFocus();
      await tester.pump();

      await press(tester, LogicalKeyboardKey.arrowDown);

      expect(nodes[2].hasPrimaryFocus, isTrue);
    });

    testWidgets('at the last tile ↓ is passed on', (WidgetTester tester) async {
      final nodes = makeNodes(2);
      await tester.pumpWidget(
        app(
          MechanixList(
            children: [
              for (var i = 0; i < 2; i++)
                MechanixListTile(labelText: 'Row $i', focusNode: nodes[i]),
            ],
          ),
        ),
      );
      nodes[1].requestFocus();
      await tester.pump();

      // Nothing below the list, so the app's own directional focus has
      // nowhere to go either: focus stays on the last tile.
      await press(tester, LogicalKeyboardKey.arrowDown);

      expect(nodes[1].hasPrimaryFocus, isTrue);
    });

    testWidgets('with no tile focused, ↓ goes to the first and ↑ to the last', (
      WidgetTester tester,
    ) async {
      final nodes = makeNodes(3);
      final key = GlobalKey<MechanixKeyboardListState>();
      await tester.pumpWidget(
        app(
          MechanixKeyboardList(
            key: key,
            child: Column(
              children: [
                for (var i = 0; i < 3; i++)
                  MechanixListTile(labelText: 'Row $i', focusNode: nodes[i]),
              ],
            ),
          ),
        ),
      );

      key.currentState!.focus();
      await tester.pump();
      await press(tester, LogicalKeyboardKey.arrowDown);
      expect(nodes[0].hasPrimaryFocus, isTrue);

      key.currentState!.focus();
      await tester.pump();
      await press(tester, LogicalKeyboardKey.arrowUp);
      expect(nodes[2].hasPrimaryFocus, isTrue);
    });

    testWidgets('autofocus takes focus so ↓ works straight away', (
      WidgetTester tester,
    ) async {
      final nodes = makeNodes(2);
      await tester.pumpWidget(
        app(
          MechanixKeyboardList(
            autofocus: true,
            child: Column(
              children: [
                for (var i = 0; i < 2; i++)
                  MechanixListTile(labelText: 'Row $i', focusNode: nodes[i]),
              ],
            ),
          ),
        ),
      );
      await tester.pump();

      await press(tester, LogicalKeyboardKey.arrowDown);

      expect(nodes[0].hasPrimaryFocus, isTrue);
    });

    testWidgets('one wrapper joins several MechanixList sections', (
      WidgetTester tester,
    ) async {
      final nodes = makeNodes(4);
      await tester.pumpWidget(
        app(
          MechanixKeyboardList(
            child: Column(
              children: [
                for (var section = 0; section < 2; section++)
                  MechanixList(
                    children: [
                      for (var i = 0; i < 2; i++)
                        MechanixListTile(
                          labelText: 'Row $section.$i',
                          focusNode: nodes[section * 2 + i],
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
      nodes[1].requestFocus();
      await tester.pump();

      await press(tester, LogicalKeyboardKey.arrowDown);
      expect(nodes[2].hasPrimaryFocus, isTrue);
      await press(tester, LogicalKeyboardKey.arrowUp);
      expect(nodes[1].hasPrimaryFocus, isTrue);
    });

    testWidgets('↓ scrolls a lazy ListView to the next tile', (
      WidgetTester tester,
    ) async {
      const count = 40;
      final nodes = makeNodes(count);
      await tester.pumpWidget(
        app(
          MechanixKeyboardList(
            child: ListView.builder(
              itemCount: count,
              itemBuilder: (context, i) =>
                  MechanixListTile(labelText: 'Row $i', focusNode: nodes[i]),
            ),
          ),
        ),
      );
      nodes[0].requestFocus();
      await tester.pump();

      for (var i = 0; i < 20; i++) {
        await press(tester, LogicalKeyboardKey.arrowDown);
      }

      expect(nodes[20].hasPrimaryFocus, isTrue);
      final screen = tester.getRect(find.byType(ListView));
      final row = tester.getRect(
        find.widgetWithText(MechanixListTile, 'Row 20'),
      );
      expect(row.top, greaterThanOrEqualTo(screen.top));
      expect(row.bottom, lessThanOrEqualTo(screen.bottom + 0.01));
    });

    testWidgets('↓ from a focused switch inside a tile goes to the next tile', (
      WidgetTester tester,
    ) async {
      final nodes = makeNodes(2);
      final switchNode = FocusNode();
      addTearDown(switchNode.dispose);
      await tester.pumpWidget(
        app(
          MechanixList(
            children: [
              MechanixListTile(
                labelText: 'Row 0',
                focusNode: nodes[0],
                trailingWidgets: [
                  Switch(focusNode: switchNode, value: false, onChanged: (_) {}),
                ],
              ),
              MechanixListTile(labelText: 'Row 1', focusNode: nodes[1]),
            ],
          ),
        ),
      );
      switchNode.requestFocus();
      await tester.pump();

      await press(tester, LogicalKeyboardKey.arrowDown);

      expect(nodes[1].hasPrimaryFocus, isTrue);
    });

    testWidgets('expandable: children are skipped until expanded', (
      WidgetTester tester,
    ) async {
      final nodes = makeNodes(3); // after, child, before
      await tester.pumpWidget(
        app(
          MechanixList(
            children: [
              MechanixListTile(labelText: 'Before', focusNode: nodes[2]),
              MechanixExpandableListTile(
                labelText: 'Group',
                children: [
                  MechanixListTile(labelText: 'Child', focusNode: nodes[1]),
                ],
              ),
              MechanixListTile(labelText: 'After', focusNode: nodes[0]),
            ],
          ),
        ),
      );
      nodes[2].requestFocus();
      await tester.pump();

      // Before → Group header → After (collapsed child skipped).
      await press(tester, LogicalKeyboardKey.arrowDown);
      await press(tester, LogicalKeyboardKey.arrowDown);
      expect(nodes[0].hasPrimaryFocus, isTrue);

      // Back to the header, Enter expands, ↓ reaches the child.
      await press(tester, LogicalKeyboardKey.arrowUp);
      await press(tester, LogicalKeyboardKey.enter);
      await press(tester, LogicalKeyboardKey.arrowDown);
      expect(nodes[1].hasPrimaryFocus, isTrue);
      await press(tester, LogicalKeyboardKey.arrowDown);
      expect(nodes[0].hasPrimaryFocus, isTrue);
    });

    testWidgets('Ctrl+↓ is left alone', (WidgetTester tester) async {
      final nodes = makeNodes(2);
      await tester.pumpWidget(
        app(
          MechanixList(
            children: [
              for (var i = 0; i < 2; i++)
                MechanixListTile(labelText: 'Row $i', focusNode: nodes[i]),
            ],
          ),
        ),
      );
      nodes[0].requestFocus();
      await tester.pump();

      await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
      await press(tester, LogicalKeyboardKey.arrowDown);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);

      expect(nodes[0].hasPrimaryFocus, isTrue);
    });

    testWidgets('a tile without its own focusNode still takes part', (
      WidgetTester tester,
    ) async {
      final first = FocusNode();
      addTearDown(first.dispose);
      var taps = 0;
      await tester.pumpWidget(
        app(
          MechanixList(
            children: [
              MechanixListTile(labelText: 'Row 0', focusNode: first),
              MechanixListTile(labelText: 'Row 1', onTap: () => taps++),
            ],
          ),
        ),
      );
      first.requestFocus();
      await tester.pump();

      await press(tester, LogicalKeyboardKey.arrowDown);
      await press(tester, LogicalKeyboardKey.enter);

      expect(first.hasFocus, isFalse);
      expect(taps, 1);
    });
  });
}
