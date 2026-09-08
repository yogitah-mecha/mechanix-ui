import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// A menu selector widget that displays and updates the current [ThemeMode].
class ThemeModeMenu extends StatelessWidget {
  /// The currently selected [ThemeMode].
  ///
  /// If null, defaults to [MechanixThemeData.mode] from the nearest [MechanixTheme].
  final ThemeMode? currentMode;

  /// Callback triggered when a new [ThemeMode] is chosen.
  ///
  /// If null, automatically calls [MechanixTheme.setThemeMode].
  final ValueChanged<ThemeMode>? onThemeModeChanged;

  const ThemeModeMenu({
    super.key,
    this.currentMode,
    this.onThemeModeChanged,
  });

  IconData _iconForMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return Icons.desktop_windows_outlined;
      case ThemeMode.light:
        return Icons.wb_sunny_outlined;
      case ThemeMode.dark:
        return Icons.nightlight_round;
    }
  }

  String _labelForMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = MechanixTheme.maybeOf(context);
    final activeMode = currentMode ?? theme?.mode ?? ThemeMode.system;
    final colorScheme = theme?.colorScheme ?? Theme.of(context).colorScheme;

    return PopupMenuButton<ThemeMode>(
      tooltip: 'Select Theme Mode',
      initialValue: activeMode,
      onSelected: (mode) {
        if (onThemeModeChanged != null) {
          onThemeModeChanged!(mode);
        } else {
          MechanixTheme.setThemeMode(context, mode);
        }
      },
      borderRadius: BorderRadius.circular(8),
      itemBuilder: (context) => [
        PopupMenuItem<ThemeMode>(
          enabled: false,
          child: Text(
            'Theme Mode',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<ThemeMode>(
          value: ThemeMode.system,
          child: Row(
            children: [
              Icon(Icons.desktop_windows_outlined, size: 16),
              SizedBox(width: 8),
              Text('System'),
            ],
          ),
        ),
        const PopupMenuItem<ThemeMode>(
          value: ThemeMode.light,
          child: Row(
            children: [
              Icon(Icons.wb_sunny_outlined, size: 16),
              SizedBox(width: 8),
              Text('Light'),
            ],
          ),
        ),
        const PopupMenuItem<ThemeMode>(
          value: ThemeMode.dark,
          child: Row(
            children: [
              Icon(Icons.nightlight_round, size: 16),
              SizedBox(width: 8),
              Text('Dark'),
            ],
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Icon(
              _iconForMode(activeMode),
              size: 18,
              color: colorScheme.onSurface,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Theme Mode',
                    style: TextStyle(
                      fontSize: 10,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    _labelForMode(activeMode),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.unfold_more_rounded,
              size: 16,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
