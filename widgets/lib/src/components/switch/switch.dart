import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets/widgets.dart';

export 'switch_style.dart';
export 'switch_theme.dart';

/// A customizable toggle switch following the Mechanix design system.
///
/// Features a fixed 88x40px track, 96x48px hug container & tap target area with
/// 96x48px focused border, 32x32px square sliding handle, state-aware handle & text colors,
/// and optional ON/OFF labels.
class MechanixSwitch extends StatefulWidget {
  const MechanixSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.showLabel = true,
    this.labelOn = 'ON',
    this.labelOff = 'OFF',
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 200),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.theme,
  });

  /// Whether this switch is on or off.
  final bool value;

  /// Called when the user toggles the switch.
  /// If null, the switch is disabled.
  final ValueChanged<bool>? onChanged;

  /// Controls whether internal ON/OFF text label is rendered inside the track.
  final bool showLabel;

  /// Custom text string displayed when active (defaults to 'ON').
  final String labelOn;

  /// Custom text string displayed when inactive (defaults to 'OFF').
  final String labelOff;

  /// Optional FocusNode.
  final FocusNode? focusNode;

  /// Whether this switch should auto focus on init.
  final bool autofocus;

  /// Toggle animation duration.
  final Duration duration;

  /// Toggle animation easing curve.
  final Curve curve;

  /// Custom theme override for this switch instance.
  final SwitchThemeDataConfig? theme;

  bool get isEnabled => onChanged != null;

  @override
  State<MechanixSwitch> createState() => _MechanixSwitchState();
}

class _MechanixSwitchState extends State<MechanixSwitch> {
  static const double _trackWidth = 88.0;
  static const double _trackHeight = 40.0;
  static const double _handleSize = 32.0;
  static const double _padding = 4.0;
  static const double _handleTravelDistance =
      _trackWidth - (2 * _padding) - _handleSize; // 48.0
  static const double _targetWidth = 96.0;
  static const double _targetHeight = 48.0;

  late FocusNode _focusNode;
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;
  bool _isDragging = false;
  double _dragPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _dragPosition = widget.value ? _handleTravelDistance : 0.0;
  }

  @override
  void didUpdateWidget(MechanixSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChange);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_handleFocusChange);
    }
    if (widget.value != oldWidget.value && !_isDragging) {
      _dragPosition = widget.value ? _handleTravelDistance : 0.0;
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_handleFocusChange);
    }
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  void _handleTap() {
    if (!widget.isEnabled) return;
    widget.onChanged!(!widget.value);
  }

  void _handleDragStart(DragStartDetails details) {
    if (!widget.isEnabled) return;
    setState(() {
      _isDragging = true;
      _isPressed = true;
      _dragPosition = widget.value ? _handleTravelDistance : 0.0;
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!widget.isEnabled) return;
    final delta = details.primaryDelta ?? 0.0;
    setState(() {
      _dragPosition = (_dragPosition + delta).clamp(0.0, _handleTravelDistance);
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!widget.isEnabled) return;
    setState(() {
      _isDragging = false;
      _isPressed = false;
    });

    final velocity = details.primaryVelocity ?? 0.0;
    final bool targetValue;

    if (velocity.abs() >= 150.0) {
      // Fast swipe / fling: velocity determines direction
      targetValue = velocity > 0;
    } else {
      // Deliberate drag: position relative to halfway mark determines direction
      targetValue = _dragPosition >= (_handleTravelDistance / 2);
    }

    if (targetValue != widget.value) {
      widget.onChanged!(targetValue);
    }
  }

  void _handleDragCancel() {
    if (!widget.isEnabled) return;
    setState(() {
      _isDragging = false;
      _isPressed = false;
    });
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (!widget.isEnabled) {
      return KeyEventResult.ignored;
    }

    if (event is KeyDownEvent &&
        (event.logicalKey == LogicalKeyboardKey.space ||
            event.logicalKey == LogicalKeyboardKey.enter)) {
      _handleTap();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final mergedTheme = MechanixSwitchTheme.of(context).merge(widget.theme);
    final resolvedStyle = SwitchStyleResolver.resolveStyle(
      context: context,
      value: widget.value,
      isEnabled: widget.isEnabled,
      isHovered: _isHovered,
      isPressed: _isPressed,
      isFocused: _isFocused,
      theme: mergedTheme,
    );

    final handleLeft = _isDragging
        ? (_padding + _dragPosition)
        : (widget.value ? (_padding + _handleTravelDistance) : _padding);

    // Text style
    final baseTextStyle =
        resolvedStyle.textStyle ??
        Theme.of(context).textTheme.titleMedium ??
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
        );

    final currentText = widget.value ? widget.labelOn : widget.labelOff;

    Widget handle = Container(
      width: _handleSize,
      height: _handleSize,
      decoration: BoxDecoration(
        color: resolvedStyle.handleColor,
        border: Border.fromBorderSide(resolvedStyle.handleBorder),
      ),
    );

    if (_isDragging) {
      handle = Positioned(
        left: handleLeft,
        top: _padding,
        width: _handleSize,
        height: _handleSize,
        child: handle,
      );
    } else {
      handle = AnimatedPositioned(
        duration: widget.duration,
        curve: widget.curve,
        left: handleLeft,
        top: _padding,
        width: _handleSize,
        height: _handleSize,
        child: handle,
      );
    }

    Widget visualTrack = AnimatedContainer(
      duration: widget.duration,
      curve: widget.curve,
      width: _trackWidth,
      height: _trackHeight,
      decoration: BoxDecoration(color: resolvedStyle.trackColor),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // 1. Text Label Layer
          if (widget.showLabel)
            AnimatedPositioned(
              duration: widget.duration,
              curve: widget.curve,
              left: widget.value ? _padding : (_padding + _handleSize),
              top: _padding,
              width: _handleTravelDistance,
              height: _handleSize,
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: widget.duration,
                  curve: widget.curve,
                  style: baseTextStyle.copyWith(color: resolvedStyle.textColor),
                  child: Text(
                    currentText.toUpperCase(),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),

          // 2. Sliding Square Handle
          handle,
        ],
      ),
    );

    final focusBorder = resolvedStyle.focusBorder;
    final focusBorderWidth = mergedTheme.focusBorderWidth ?? 1.0;

    Widget switchBox = AnimatedContainer(
      duration: widget.duration,
      curve: widget.curve,
      width: _targetWidth,
      height: _targetHeight,
      decoration: BoxDecoration(
        border: focusBorder != null
            ? Border.fromBorderSide(focusBorder)
            : Border.all(color: Colors.transparent, width: focusBorderWidth),
      ),
      child: Center(child: visualTrack),
    );

    // 96x48px Hug Container and Tap Target Area
    return Focus(
      focusNode: _focusNode,
      autofocus: widget.autofocus,
      onKeyEvent: _handleKeyEvent,
      child: Center(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: MouseRegion(
          cursor: widget.isEnabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          onEnter: (_) {
            if (widget.isEnabled) setState(() => _isHovered = true);
          },
          onExit: (_) {
            if (widget.isEnabled) setState(() => _isHovered = false);
          },
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _handleTap,
            onTapDown: (_) {
              if (widget.isEnabled) setState(() => _isPressed = true);
            },
            onTapUp: (_) {
              if (widget.isEnabled) setState(() => _isPressed = false);
            },
            onTapCancel: () {
              if (widget.isEnabled && !_isDragging) {
                setState(() => _isPressed = false);
              }
            },
            onHorizontalDragStart: _handleDragStart,
            onHorizontalDragUpdate: _handleDragUpdate,
            onHorizontalDragEnd: _handleDragEnd,
            onHorizontalDragCancel: _handleDragCancel,
            child: switchBox,
          ),
        ),
      ),
    );
  }
}
