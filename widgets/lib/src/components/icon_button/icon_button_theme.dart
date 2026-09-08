import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Scoped Theme extension config for [MechanixIconButton].
@immutable
class IconButtonThemeDataConfig
    extends ThemeExtension<IconButtonThemeDataConfig>
    with Diagnosticable {
  const IconButtonThemeDataConfig({
    this.backgroundColor,
    this.foregroundColor,
    this.side,
    this.iconSize,
    this.borderRadius,
    this.elevation,
    this.focusIndicatorWidth,
  });

  /// State-aware background color property.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// State-aware foreground/icon color property.
  final WidgetStateProperty<Color?>? foregroundColor;

  /// State-aware border side property.
  final WidgetStateProperty<BorderSide?>? side;

  final double? iconSize;
  final BorderRadius? borderRadius;
  final double? elevation;
  final double? focusIndicatorWidth;

  @override
  IconButtonThemeDataConfig copyWith({
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? foregroundColor,
    WidgetStateProperty<BorderSide?>? side,
    double? iconSize,
    BorderRadius? borderRadius,
    double? elevation,
    double? focusIndicatorWidth,
  }) {
    return IconButtonThemeDataConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      side: side ?? this.side,
      iconSize: iconSize ?? this.iconSize,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      focusIndicatorWidth: focusIndicatorWidth ?? this.focusIndicatorWidth,
    );
  }

  IconButtonThemeDataConfig merge(IconButtonThemeDataConfig? other) {
    if (other == null) return this;

    return copyWith(
      backgroundColor: other.backgroundColor,
      foregroundColor: other.foregroundColor,
      side: other.side,
      iconSize: other.iconSize,
      borderRadius: other.borderRadius,
      elevation: other.elevation,
      focusIndicatorWidth: other.focusIndicatorWidth,
    );
  }

  @override
  IconButtonThemeDataConfig lerp(
    ThemeExtension<IconButtonThemeDataConfig>? other,
    double t,
  ) {
    if (other is! IconButtonThemeDataConfig) return this;

    return IconButtonThemeDataConfig(
      backgroundColor: WidgetStateProperty.lerp<Color?>(
        backgroundColor,
        other.backgroundColor,
        t,
        Color.lerp,
      ),
      foregroundColor: WidgetStateProperty.lerp<Color?>(
        foregroundColor,
        other.foregroundColor,
        t,
        Color.lerp,
      ),
      side: WidgetStateProperty.lerp<BorderSide?>(side, other.side, t, (
        a,
        b,
        t,
      ) {
        if (a == null && b == null) {
          return null;
        }

        return BorderSide.lerp(a ?? BorderSide.none, b ?? BorderSide.none, t);
      }),
      iconSize: lerpDouble(iconSize, other.iconSize, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      elevation: lerpDouble(elevation, other.elevation, t),
      focusIndicatorWidth: lerpDouble(
        focusIndicatorWidth,
        other.focusIndicatorWidth,
        t,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(DiagnosticsProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty('foregroundColor', foregroundColor));
    properties.add(DiagnosticsProperty('side', side));
    properties.add(DiagnosticsProperty('iconSize', iconSize));
    properties.add(DiagnosticsProperty('borderRadius', borderRadius));
    properties.add(DiagnosticsProperty('elevation', elevation));
    properties.add(
      DiagnosticsProperty('focusIndicatorWidth', focusIndicatorWidth),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IconButtonThemeDataConfig &&
        backgroundColor == other.backgroundColor &&
        foregroundColor == other.foregroundColor &&
        side == other.side &&
        iconSize == other.iconSize &&
        borderRadius == other.borderRadius &&
        elevation == other.elevation &&
        focusIndicatorWidth == other.focusIndicatorWidth;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      foregroundColor,
      side,
      iconSize,
      borderRadius,
      elevation,
      focusIndicatorWidth,
    );
  }
}

class MechanixIconButtonTheme extends InheritedTheme {
  const MechanixIconButtonTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final IconButtonThemeDataConfig data;

  static IconButtonThemeDataConfig of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixIconButtonTheme>();

    return theme?.data ??
        Theme.of(context).extension<IconButtonThemeDataConfig>() ??
        const IconButtonThemeDataConfig();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixIconButtonTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixIconButtonTheme oldWidget) {
    return data != oldWidget.data;
  }
}
