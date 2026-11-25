import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Moves keyboard focus between the list tiles below it with ↑/↓. Enter (or
/// Space) on the focused tile calls its `onTap`.
///
/// Every [MechanixListTile] below this widget takes part, including the
/// tiles inside [MechanixDraggableListTile], [MechanixSwipableListTile] and
/// [MechanixExpandableListTile]. Rows are visited top to bottom, in the order
/// they are laid out, so lazily built lists (`ListView.builder`) work too.
///
/// [MechanixList] and [MechanixSegmentedList] add one of these themselves
/// when there is none above them. Wrap a whole page (e.g. a settings page
/// made of several sections) in one to move through all its tiles as one
/// list, or wrap a `ListView.builder` of tiles.
///
/// At the first or last tile the key is passed on, so the app's normal
/// arrow-key focus movement can take it to the next list or control.
class MechanixKeyboardList extends StatefulWidget {
  const MechanixKeyboardList({
    super.key,
    required this.child,
    this.autofocus = false,
  });

  final Widget child;

  /// Take keyboard focus when shown, so ↓/↑ go to the first/last tile
  /// straight away.
  final bool autofocus;

  /// The nearest [MechanixKeyboardList] above [context], if any.
  static MechanixKeyboardListState? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_MechanixKeyboardListScope>()
      ?.state;

  @override
  State<MechanixKeyboardList> createState() => MechanixKeyboardListState();
}

class MechanixKeyboardListState extends State<MechanixKeyboardList> {
  /// Built rows: focus node → the row's context (used for its position).
  final Map<FocusNode, BuildContext> _items = {};
  final FocusNode _node = FocusNode(
    debugLabel: 'MechanixKeyboardList',
    skipTraversal: true,
  );

  /// Adds a row. Called by [MechanixListTile]; a custom row can call it too.
  void register(FocusNode node, BuildContext itemContext) =>
      _items[node] = itemContext;

  /// Removes a row added with [register].
  void unregister(FocusNode node) => _items.remove(node);

  /// Gives this list keyboard focus without focusing a tile; the next ↓/↑
  /// goes to the first/last tile.
  void focus() => _node.requestFocus();

  /// Rows that can take focus, top to bottom (left to right on one line).
  List<MapEntry<FocusNode, BuildContext>> _orderedItems() {
    final rows = <(Offset, MapEntry<FocusNode, BuildContext>)>[];
    for (final entry in _items.entries) {
      if (!entry.key.canRequestFocus || !entry.value.mounted) continue;
      final box = entry.value.findRenderObject();
      if (box is! RenderBox || !box.attached || !box.hasSize) continue;
      rows.add((box.localToGlobal(Offset.zero), entry));
    }
    rows.sort((a, b) {
      final dy = a.$1.dy.compareTo(b.$1.dy);
      return dy != 0 ? dy : a.$1.dx.compareTo(b.$1.dx);
    });
    return [for (final row in rows) row.$2];
  }

  /// Moves focus one row down ([delta] > 0) or up. With no row focused,
  /// goes to the first (down) or last (up) row. Returns false when there is
  /// no row to go to.
  bool move(int delta) {
    final rows = _orderedItems();
    if (rows.isEmpty) return false;
    final current = rows.indexWhere((row) => row.key.hasFocus);
    final target = current == -1
        ? (delta > 0 ? 0 : rows.length - 1)
        : current + delta.sign;
    if (target < 0 || target >= rows.length) return false;

    final row = rows[target];
    row.key.requestFocus();
    Scrollable.ensureVisible(
      row.value,
      duration: const Duration(milliseconds: 120),
      alignmentPolicy: delta > 0
          ? ScrollPositionAlignmentPolicy.keepVisibleAtEnd
          : ScrollPositionAlignmentPolicy.keepVisibleAtStart,
    );
    return true;
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final keyboard = HardwareKeyboard.instance;
    // Ctrl+↑/↓ etc. keep their usual meaning (e.g. scrolling).
    if (keyboard.isControlPressed ||
        keyboard.isAltPressed ||
        keyboard.isMetaPressed ||
        keyboard.isShiftPressed) {
      return KeyEventResult.ignored;
    }
    final int delta;
    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      delta = 1;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      delta = -1;
    } else {
      return KeyEventResult.ignored;
    }
    return move(delta) ? KeyEventResult.handled : KeyEventResult.ignored;
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _node,
      autofocus: widget.autofocus,
      onKeyEvent: _onKey,
      child: _MechanixKeyboardListScope(state: this, child: widget.child),
    );
  }
}

class _MechanixKeyboardListScope extends InheritedWidget {
  const _MechanixKeyboardListScope({required this.state, required super.child});

  final MechanixKeyboardListState state;

  @override
  bool updateShouldNotify(_MechanixKeyboardListScope oldWidget) =>
      state != oldWidget.state;
}
