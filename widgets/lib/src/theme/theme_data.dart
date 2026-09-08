import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// The immutable resolved data for a Mechanix theme.
@immutable
class MechanixThemeData with Diagnosticable {
  /// Creates a [MechanixThemeData].
  const MechanixThemeData({
    this.accentColor,
    required this.themeMode,
    required this.light,
    required this.dark,
    required this.activeBrightness,
    this.onThemeModeChanged,
    this.onAccentColorChanged,
  });

  /// The custom accent color, or null if using default brand orange.
  final Color? accentColor;

  /// The active [ThemeMode].
  final ThemeMode themeMode;

  /// The light [ThemeData] configured with Mechanix typography and colors.
  final ThemeData light;

  /// The dark [ThemeData] configured with Mechanix typography and colors.
  final ThemeData dark;

  /// The resolved [Brightness] based on [themeMode] and platform brightness.
  final Brightness activeBrightness;

  /// Callback to update the theme mode on the enclosing theme scope.
  final void Function(ThemeMode mode)? onThemeModeChanged;

  /// Callback to update the accent color on the enclosing theme scope.
  final void Function(Color? color)? onAccentColorChanged;

  /// Alias for [themeMode] for concise builder usage (`theme.mode`).
  ThemeMode get mode => themeMode;

  /// The active [ThemeData] according to the resolved mode and brightness.
  ThemeData get theme => activeBrightness == Brightness.dark ? dark : light;

  /// The active [ColorScheme] for the current theme.
  ColorScheme get colorScheme => theme.colorScheme;

  /// The active [TextTheme] for the current theme.
  TextTheme get textTheme => theme.textTheme;

  /// Dynamically updates the theme mode of the enclosing theme scope.
  void setThemeMode(ThemeMode mode) => onThemeModeChanged?.call(mode);

  /// Dynamically updates the accent color of the enclosing theme scope.
  void setAccentColor(Color? color) => onAccentColorChanged?.call(color);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('accentColor', accentColor));
    properties.add(EnumProperty<ThemeMode>('themeMode', themeMode));
    properties.add(DiagnosticsProperty<ThemeData>('light', light));
    properties.add(DiagnosticsProperty<ThemeData>('dark', dark));
    properties.add(
      EnumProperty<Brightness>('activeBrightness', activeBrightness),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MechanixThemeData &&
        other.accentColor == accentColor &&
        other.themeMode == themeMode &&
        other.light == light &&
        other.dark == dark &&
        other.activeBrightness == activeBrightness;
  }

  @override
  int get hashCode =>
      Object.hash(accentColor, themeMode, light, dark, activeBrightness);
}
