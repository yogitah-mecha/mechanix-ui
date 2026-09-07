import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Helper for constructing Material [ButtonStyle] configurations for [MechanixIconButton].
abstract class IconButtonStyleResolver {
  const IconButtonStyleResolver();

  /// Creates a Material [ButtonStyle] for [MechanixIconButton] using variant,
  /// type, sizing spec, theme data, and custom color overrides.
  static ButtonStyle createButtonStyle({
    required BuildContext context,
    required IconButtonVariant variant,
    required IconButtonType type,
    required IconButtonSizeConfig sizeSpec,
    IconButtonThemeDataConfig? theme,
    Color? customBackgroundColor,
    Color? customHoverColor,
    Color? customPressedColor,
    Color? customDisabledColor,
    Color? customForegroundColor,
    Color? customHoverForegroundColor,
    Color? customPressedForegroundColor,
    Color? customDisabledForegroundColor,
    Color? customBorderColor,
    double? customBorderWidth,
    Color? customFocusBorderColor,
    Duration? duration,
    Curve? curve,
    bool showFocusIndicator = true,
  }) {
    final scheme = context.colorScheme;
    final shapeTheme = context.shape;

    // 1. Shape resolution:
    // Custom theme.borderRadius -> ShapeTheme.full (rounded) -> ShapeTheme.none (square)
    final borderRadius =
        theme?.borderRadius ??
        switch (type) {
          IconButtonType.square => shapeTheme.none,
          IconButtonType.rounded => shapeTheme.full,
        };
    final shape = RoundedRectangleBorder(borderRadius: borderRadius);

    // 2. Default color resolution per variant:
    late final Color defaultBg;
    late final Color defaultFg;
    late final Color? defaultBorderColor;
    late final double defaultBorderWidth;

    switch (variant) {
      case IconButtonVariant.filled:
        defaultBg = scheme.primary;
        defaultFg = scheme.onSurface;
        defaultBorderColor = scheme.secondaryFixedDim;
        defaultBorderWidth = 1.0;
        break;
      case IconButtonVariant.tonal:
        defaultBg = scheme.secondary;
        defaultFg = scheme.onSecondaryFixed;
        defaultBorderColor = null;
        defaultBorderWidth = 0.0;
        break;
      case IconButtonVariant.outline:
        defaultBg = scheme.secondary;
        defaultFg = scheme.onSecondaryFixed;
        defaultBorderColor = scheme.outline;
        defaultBorderWidth = 2.0;
        break;
      case IconButtonVariant.standard:
        defaultBg = Colors.transparent;
        defaultFg = scheme.onSecondaryFixed;
        defaultBorderColor = null;
        defaultBorderWidth = 0.0;
        break;
    }

    final baseBg = customBackgroundColor ?? theme?.backgroundColor ?? defaultBg;
    final baseFg = customForegroundColor ?? theme?.foregroundColor ?? defaultFg;
    final baseBorderColor =
        customBorderColor ?? theme?.borderColor ?? defaultBorderColor;
    final baseBorderWidth =
        customBorderWidth ?? theme?.borderWidth ?? defaultBorderWidth;

    // 3. State-aware background resolution
    final backgroundColorProperty = WidgetStateProperty.resolveWith<Color?>((
      states,
    ) {
      if (states.contains(WidgetState.disabled)) {
        if (customDisabledColor != null || theme?.disabledColor != null) {
          return customDisabledColor ?? theme?.disabledColor;
        }
        return switch (variant) {
          IconButtonVariant.filled ||
          IconButtonVariant.tonal => scheme.onSurface.withValues(alpha: 0.10),
          IconButtonVariant.outline => Colors.transparent,
          IconButtonVariant.standard => Colors.transparent,
        };
      }

      if (states.contains(WidgetState.pressed)) {
        if (customPressedColor != null || theme?.pressedColor != null) {
          return customPressedColor ?? theme?.pressedColor;
        }
        final stateLayerColor = switch (variant) {
          IconButtonVariant.filled => scheme.onPrimary,
          IconButtonVariant.tonal => scheme.onSecondaryContainer,
          IconButtonVariant.outline ||
          IconButtonVariant.standard => scheme.onSurfaceVariant,
        };
        return _applyStateLayer(
          baseColor: baseBg,
          stateLayerColor: stateLayerColor,
          opacity: 0.12,
        );
      }

      if (states.contains(WidgetState.hovered)) {
        if (customHoverColor != null || theme?.hoverColor != null) {
          return customHoverColor ?? theme?.hoverColor;
        }
        final stateLayerColor = switch (variant) {
          IconButtonVariant.filled => scheme.onPrimary,
          IconButtonVariant.tonal => scheme.onSecondaryContainer,
          IconButtonVariant.outline ||
          IconButtonVariant.standard => scheme.onSurfaceVariant,
        };
        return _applyStateLayer(
          baseColor: baseBg,
          stateLayerColor: stateLayerColor,
          opacity: 0.08,
        );
      }

      if (states.contains(WidgetState.focused)) {
        final stateLayerColor = switch (variant) {
          IconButtonVariant.filled => scheme.onPrimary,
          IconButtonVariant.tonal => scheme.onSecondaryContainer,
          IconButtonVariant.outline ||
          IconButtonVariant.standard => scheme.onSurfaceVariant,
        };
        return _applyStateLayer(
          baseColor: baseBg,
          stateLayerColor: stateLayerColor,
          opacity: 0.08,
        );
      }

      return baseBg;
    });

    // 4. State-aware foreground resolution
    final foregroundColorProperty = WidgetStateProperty.resolveWith<Color?>((
      states,
    ) {
      if (states.contains(WidgetState.disabled)) {
        return customDisabledForegroundColor ??
            theme?.disabledForegroundColor ??
            scheme.onSurface.withValues(alpha: 0.38);
      }
      if (states.contains(WidgetState.pressed)) {
        return customPressedForegroundColor ??
            theme?.pressedForegroundColor ??
            baseFg;
      }
      if (states.contains(WidgetState.hovered)) {
        return customHoverForegroundColor ??
            theme?.hoverForegroundColor ??
            baseFg;
      }
      return baseFg;
    });

    // 5. State-aware border side resolution
    final sideProperty = WidgetStateProperty.resolveWith<BorderSide?>((states) {
      final defaultFocusColor = switch (variant) {
        IconButtonVariant.standard => scheme.secondary,
        _ => scheme.secondaryFixedDim,
      };

      final focusBorderColor =
          customFocusBorderColor ??
          theme?.focusBorderColor ??
          defaultFocusColor;
      final focusWidth = customBorderWidth ?? theme?.borderWidth ?? 3.0;

      if (states.contains(WidgetState.focused) && showFocusIndicator) {
        return BorderSide(color: focusBorderColor, width: focusWidth);
      }

      if (states.contains(WidgetState.disabled)) {
        return switch (variant) {
          IconButtonVariant.filled => BorderSide(
            color: scheme.secondary.withValues(alpha: 0.10),
            width: baseBorderWidth,
          ),
          IconButtonVariant.outline => BorderSide(
            color: (baseBorderColor ?? scheme.outline).withValues(alpha: 0.38),
            width: baseBorderWidth,
          ),
          IconButtonVariant.tonal || IconButtonVariant.standard =>
            baseBorderColor != null
                ? BorderSide(
                    color: baseBorderColor.withValues(alpha: 0.38),
                    width: baseBorderWidth,
                  )
                : null,
        };
      }

      if (baseBorderColor != null) {
        return BorderSide(color: baseBorderColor, width: baseBorderWidth);
      }

      return null;
    });

    // 6. Native tap target sizing
    final tapTargetSize = sizeSpec.minTapTargetSize > 0
        ? MaterialTapTargetSize.padded
        : MaterialTapTargetSize.shrinkWrap;

    return ButtonStyle(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      backgroundColor: backgroundColorProperty,
      foregroundColor: foregroundColorProperty,
      iconColor: foregroundColorProperty,
      side: sideProperty,
      shape: WidgetStateProperty.all(shape),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      minimumSize: WidgetStateProperty.all(
        Size(sizeSpec.dimension, sizeSpec.dimension),
      ),
      fixedSize: WidgetStateProperty.all(
        Size(sizeSpec.dimension, sizeSpec.dimension),
      ),
      alignment: Alignment.center,
      elevation: WidgetStateProperty.all(theme?.elevation ?? 0.0),
      iconSize: WidgetStateProperty.all(theme?.iconSize ?? sizeSpec.iconSize),
      animationDuration: duration ?? const Duration(milliseconds: 200),
      tapTargetSize: tapTargetSize,
      mouseCursor: WidgetStateProperty.resolveWith<MouseCursor>((states) {
        if (states.contains(WidgetState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      }),
    );
  }
}

Color _applyStateLayer({
  required Color baseColor,
  required Color stateLayerColor,
  required double opacity,
}) {
  if (baseColor == Colors.transparent) {
    return stateLayerColor.withValues(alpha: opacity);
  }
  return Color.alphaBlend(
    stateLayerColor.withValues(alpha: opacity),
    baseColor,
  );
}
