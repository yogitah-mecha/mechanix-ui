import 'package:flutter/material.dart';

import '../foundation/colors/colors.dart';
import 'theme.dart';

/// A reactive theme widget that provides Mechanix theme configurations to descendants.
///
/// Use [MechanixThemeScope] at the root of your application or above a subtree to
/// dynamically manage theme mode (light, dark, system) and accent colors.
class MechanixThemeScope extends StatefulWidget implements MechanixTheme {
  /// Creates a [MechanixThemeScope] widget.
  ///
  /// Either [builder] or [child] must be provided.
  const MechanixThemeScope({
    super.key,
    this.accentColor,
    this.themeMode = ThemeMode.system,
    this.builder,
    this.child,
  }) : assert(
         builder != null || child != null,
         'Either builder or child must be provided',
       );

  /// The custom accent color for generating the brand colors.
  final Color? accentColor;

  /// The theme mode (light, dark, or system). Defaults to [ThemeMode.system].
  final ThemeMode themeMode;

  /// An optional builder that constructs widgets given the resolved [MechanixThemeData].
  final ValueWidgetBuilder<MechanixThemeData>? builder;

  /// The widget below this widget in the tree.
  final Widget? child;

  /// Obtains the nearest [MechanixThemeData] from the given [context].
  static MechanixThemeData of(BuildContext context) {
    final theme = maybeOf(context);
    assert(theme != null, 'No MechanixTheme found in the given context.');
    return theme!;
  }

  /// Obtains the nearest [MechanixThemeData] from the given [context], or null if none exists.
  static MechanixThemeData? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_MechanixInheritedTheme>()
        ?.data;
  }

  /// Updates the theme mode for the nearest enclosing [MechanixThemeScope].
  static void setThemeMode(BuildContext context, ThemeMode mode) {
    of(context).setThemeMode(mode);
  }

  /// Updates the accent color for the nearest enclosing [MechanixThemeScope].
  static void setAccentColor(BuildContext context, Color? color) {
    of(context).setAccentColor(color);
  }

  @override
  State<MechanixThemeScope> createState() => _MechanixThemeScopeState();
}

class _MechanixThemeScopeState extends State<MechanixThemeScope> {
  late ThemeMode _themeMode;
  Color? _accentColor;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.themeMode;
    _accentColor = widget.accentColor;
  }

  @override
  void didUpdateWidget(MechanixThemeScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.themeMode != oldWidget.themeMode) {
      _themeMode = widget.themeMode;
    }
    if (widget.accentColor != oldWidget.accentColor) {
      _accentColor = widget.accentColor;
    }
  }

  void _setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      setState(() {
        _themeMode = mode;
      });
    }
  }

  void _setAccentColor(Color? color) {
    if (_accentColor != color) {
      setState(() {
        _accentColor = color;
      });
    }
  }

  Brightness _resolveBrightness(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.system:
        return MediaQuery.maybePlatformBrightnessOf(context) ??
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
    }
  }

  MechanixThemeData _resolveData(BuildContext context) {
    final lightColorScheme = MechanixColors.createLightColorScheme(
      accentColor: _accentColor,
    );
    final darkColorScheme = MechanixColors.createDarkColorScheme(
      accentColor: _accentColor,
    );
    final lightTheme = MechanixTheme.createTheme(colorScheme: lightColorScheme);
    final darkTheme = MechanixTheme.createTheme(colorScheme: darkColorScheme);
    final activeBrightness = _resolveBrightness(context);

    return MechanixThemeData(
      accentColor: _accentColor,
      themeMode: _themeMode,
      light: lightTheme,
      dark: darkTheme,
      activeBrightness: activeBrightness,
      onThemeModeChanged: _setThemeMode,
      onAccentColorChanged: _setAccentColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = _resolveData(context);
    return _MechanixInheritedTheme(
      data: data,
      child:
          widget.builder?.call(context, data, widget.child) ??
          AnimatedTheme(data: data.theme, child: widget.child!),
    );
  }
}

class _MechanixInheritedTheme extends InheritedTheme {
  const _MechanixInheritedTheme({required this.data, required super.child});

  final MechanixThemeData data;

  @override
  bool updateShouldNotify(covariant _MechanixInheritedTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return _MechanixInheritedTheme(data: data, child: child);
  }
}
