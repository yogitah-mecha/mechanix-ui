import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class IconButtonThemeDataConfig
    extends ThemeExtension<IconButtonThemeDataConfig>
    with Diagnosticable {
  const IconButtonThemeDataConfig({
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.disabledColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedForegroundColor,
    this.disabledForegroundColor,
    this.focusBorderColor,
    this.borderColor,
    this.borderWidth,
    this.iconSize,
    this.borderRadius,
    this.elevation,
    this.focusIndicatorWidth,
  });

  final Color? backgroundColor;
  final Color? hoverColor;
  final Color? pressedColor;
  final Color? disabledColor;
  final Color? foregroundColor;
  final Color? hoverForegroundColor;
  final Color? pressedForegroundColor;
  final Color? disabledForegroundColor;
  final Color? focusBorderColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? iconSize;
  final BorderRadius? borderRadius;
  final double? elevation;
  final double? focusIndicatorWidth;

  @override
  IconButtonThemeDataConfig copyWith({
    Color? backgroundColor,
    Color? hoverColor,
    Color? pressedColor,
    Color? disabledColor,
    Color? foregroundColor,
    Color? hoverForegroundColor,
    Color? pressedForegroundColor,
    Color? disabledForegroundColor,
    Color? focusBorderColor,
    Color? borderColor,
    double? borderWidth,
    double? iconSize,
    BorderRadius? borderRadius,
    double? elevation,
    double? focusIndicatorWidth,
  }) {
    return IconButtonThemeDataConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      hoverColor: hoverColor ?? this.hoverColor,
      pressedColor: pressedColor ?? this.pressedColor,
      disabledColor: disabledColor ?? this.disabledColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      hoverForegroundColor: hoverForegroundColor ?? this.hoverForegroundColor,
      pressedForegroundColor:
          pressedForegroundColor ?? this.pressedForegroundColor,
      disabledForegroundColor:
          disabledForegroundColor ?? this.disabledForegroundColor,
      focusBorderColor: focusBorderColor ?? this.focusBorderColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
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
      hoverColor: other.hoverColor,
      pressedColor: other.pressedColor,
      disabledColor: other.disabledColor,
      foregroundColor: other.foregroundColor,
      hoverForegroundColor: other.hoverForegroundColor,
      pressedForegroundColor: other.pressedForegroundColor,
      disabledForegroundColor: other.disabledForegroundColor,
      focusBorderColor: other.focusBorderColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
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
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t),
      pressedColor: Color.lerp(pressedColor, other.pressedColor, t),
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t),
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t),
      hoverForegroundColor: Color.lerp(
        hoverForegroundColor,
        other.hoverForegroundColor,
        t,
      ),
      pressedForegroundColor: Color.lerp(
        pressedForegroundColor,
        other.pressedForegroundColor,
        t,
      ),
      disabledForegroundColor: Color.lerp(
        disabledForegroundColor,
        other.disabledForegroundColor,
        t,
      ),
      focusBorderColor: Color.lerp(focusBorderColor, other.focusBorderColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
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

  double? lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    return (a ?? 0.0) + ((b ?? 0.0) - (a ?? 0.0)) * t;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty('hoverColor', hoverColor));
    properties.add(DiagnosticsProperty('pressedColor', pressedColor));
    properties.add(DiagnosticsProperty('disabledColor', disabledColor));
    properties.add(DiagnosticsProperty('foregroundColor', foregroundColor));
    properties.add(
      DiagnosticsProperty('hoverForegroundColor', hoverForegroundColor),
    );
    properties.add(
      DiagnosticsProperty('pressedForegroundColor', pressedForegroundColor),
    );
    properties.add(
      DiagnosticsProperty('disabledForegroundColor', disabledForegroundColor),
    );
    properties.add(DiagnosticsProperty('focusBorderColor', focusBorderColor));
    properties.add(DiagnosticsProperty('borderColor', borderColor));
    properties.add(DiagnosticsProperty('borderWidth', borderWidth));
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
        hoverColor == other.hoverColor &&
        pressedColor == other.pressedColor &&
        disabledColor == other.disabledColor &&
        foregroundColor == other.foregroundColor &&
        hoverForegroundColor == other.hoverForegroundColor &&
        pressedForegroundColor == other.pressedForegroundColor &&
        disabledForegroundColor == other.disabledForegroundColor &&
        focusBorderColor == other.focusBorderColor &&
        borderColor == other.borderColor &&
        borderWidth == other.borderWidth &&
        iconSize == other.iconSize &&
        borderRadius == other.borderRadius &&
        elevation == other.elevation &&
        focusIndicatorWidth == other.focusIndicatorWidth;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      hoverColor,
      pressedColor,
      disabledColor,
      foregroundColor,
      hoverForegroundColor,
      pressedForegroundColor,
      disabledForegroundColor,
      focusBorderColor,
      borderColor,
      borderWidth,
      iconSize,
      borderRadius,
      elevation,
      focusIndicatorWidth,
    ]);
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
