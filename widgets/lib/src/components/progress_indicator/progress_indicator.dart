import 'package:flutter/material.dart';

import 'progress_indicator_theme.dart';

export 'progress_indicator_theme.dart';

/// Predefined size variants for Mechanix progress indicators.
enum MechanixProgressIndicatorSize {
  /// Standard variant:
  /// - Circular: 40.0 x 40.0 px with 4.0 px stroke width
  /// - Linear: 4.0 px height with capsule border radius
  standard,

  /// Large variant:
  /// - Circular: 44.0 x 44.0 px with 8.0 px stroke width
  /// - Linear: 8.0 px height with capsule border radius
  large,
}

/// A circular progress indicator following the Mechanix design system.
///
/// Visualizes progress along a circular track. Supports both determinate
/// (when [value] is provided between 0.0 and 1.0) and indeterminate
/// (when [value] is null) states.
///
/// Default sizing follows Mechanix specifications:
/// - Standard: `40.0 x 40.0` px with `4.0` px stroke width
/// - Large: `44.0 x 44.0` px with `8.0` px stroke width
///
/// Default colors:
/// - Background track: [ColorScheme.secondaryContainer] (`0xFF232325` in dark mode)
/// - Progress: [ColorScheme.primary] (`0xFFF9640D` brand orange in dark mode)
///
/// Example usage:
/// ```dart
/// // Indeterminate standard indicator
/// const MechanixCircularProgressIndicator();
///
/// // Determinate large indicator
/// const MechanixCircularProgressIndicator.large(
///   value: 0.75,
/// );
/// ```
class MechanixCircularProgressIndicator extends StatelessWidget {
  /// Creates a standard Mechanix circular progress indicator.
  const MechanixCircularProgressIndicator({
    super.key,
    this.value,
    this.size = MechanixProgressIndicatorSize.standard,
    this.width,
    this.height,
    this.strokeWidth,
    this.strokeCap,
    this.strokeAlign = CircularProgressIndicator.strokeAlignCenter,
    this.color,
    this.backgroundColor,
    this.valueColor,
    this.semanticsLabel,
    this.semanticsValue,
    this.theme,
  });

  /// Creates a large Mechanix circular progress indicator (44x44px, 8px stroke width).
  const MechanixCircularProgressIndicator.large({
    super.key,
    this.value,
    this.width,
    this.height,
    this.strokeWidth,
    this.strokeCap,
    this.strokeAlign = CircularProgressIndicator.strokeAlignCenter,
    this.color,
    this.backgroundColor,
    this.valueColor,
    this.semanticsLabel,
    this.semanticsValue,
    this.theme,
  }) : size = MechanixProgressIndicatorSize.large;

  /// If non-null, the value of this progress indicator with 0.0 representing
  /// no progress and 1.0 representing completion.
  ///
  /// If null, this progress indicator is indeterminate and displays a continuous
  /// spinning animation.
  final double? value;

  /// The size variant of this progress indicator.
  final MechanixProgressIndicatorSize size;

  /// Optional explicit width override. Defaults to [MechanixProgressIndicatorSize] dimensions.
  final double? width;

  /// Optional explicit height override. Defaults to [MechanixProgressIndicatorSize] dimensions.
  final double? height;

  /// The width of the line used to draw the circle.
  ///
  /// Defaults to 4.0 for [MechanixProgressIndicatorSize.standard] and
  /// 8.0 for [MechanixProgressIndicatorSize.large].
  final double? strokeWidth;

  /// The progress indicator's stroke cap style.
  ///
  /// Defaults to [StrokeCap.round].
  final StrokeCap? strokeCap;

  /// The relative position of the stroke on a [CircularProgressIndicator].
  ///
  /// Values typically range between -1.0 ([CircularProgressIndicator.strokeAlignInside])
  /// and 1.0 ([CircularProgressIndicator.strokeAlignOutside]).
  /// Defaults to [CircularProgressIndicator.strokeAlignCenter] (0.0).
  final double strokeAlign;

  /// The color of the progress indicator line.
  ///
  /// Defaults to [ProgressIndicatorThemeDataConfig.circularProgressColor] or
  /// [ColorScheme.primary].
  final Color? color;

  /// The color of the background track circle.
  ///
  /// Defaults to [ProgressIndicatorThemeDataConfig.circularTrackColor] or
  /// [ColorScheme.secondaryContainer].
  final Color? backgroundColor;

  /// The progress indicator's color as an animated value.
  ///
  /// If non-null, overrides [color].
  final Animation<Color?>? valueColor;

  /// The [SemanticsProperties.label] for this progress indicator.
  final String? semanticsLabel;

  /// The [SemanticsProperties.value] for this progress indicator.
  final String? semanticsValue;

  /// Custom theme override for this progress indicator instance.
  final ProgressIndicatorThemeDataConfig? theme;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeConfig = theme ?? MechanixProgressIndicatorTheme.of(context);

    final isLarge = size == MechanixProgressIndicatorSize.large;
    final defaultDimension = isLarge
        ? (themeConfig.largeCircularSize ?? 44.0)
        : (themeConfig.standardCircularSize ?? 40.0);

    final effectiveWidth = width ?? defaultDimension;
    final effectiveHeight = height ?? defaultDimension;
    final effectiveStrokeWidth =
        strokeWidth ??
        (isLarge
            ? (themeConfig.largeCircularStrokeWidth ?? 8.0)
            : (themeConfig.standardCircularStrokeWidth ?? 4.0));
    final effectiveStrokeCap =
        strokeCap ?? themeConfig.circularStrokeCap ?? StrokeCap.round;
    final effectiveTrackColor =
        backgroundColor ??
        themeConfig.circularTrackColor ??
        colorScheme.secondaryContainer;
    final effectiveProgressColor =
        color ?? themeConfig.circularProgressColor ?? colorScheme.primary;

    return SizedBox(
      width: effectiveWidth,
      height: effectiveHeight,
      child: CircularProgressIndicator(
        value: value,
        backgroundColor: effectiveTrackColor,
        color: effectiveProgressColor,
        valueColor: valueColor,
        strokeWidth: effectiveStrokeWidth,
        strokeCap: effectiveStrokeCap,
        strokeAlign: strokeAlign,
        semanticsLabel: semanticsLabel,
        semanticsValue: semanticsValue,
      ),
    );
  }
}

/// A linear progress indicator following the Mechanix design system.
///
/// Visualizes progress along a horizontal line. Supports both determinate
/// (when [value] is provided between 0.0 and 1.0) and indeterminate
/// (when [value] is null) states.
///
/// Default sizing follows Mechanix specifications:
/// - Standard: `4.0` px height with capsule border radius
/// - Large: `8.0` px height with capsule border radius
///
/// Default colors:
/// - Background track: [ColorScheme.secondaryContainer] (`0xFF232325` in dark mode)
/// - Progress: [ColorScheme.onSurfaceVariant] (`0xFF646468` in dark mode)
///
/// Example usage:
/// ```dart
/// // Indeterminate standard indicator
/// const MechanixLinearProgressIndicator();
///
/// // Determinate large indicator
/// const MechanixLinearProgressIndicator.large(
///   value: 0.5,
/// );
/// ```
class MechanixLinearProgressIndicator extends StatelessWidget {
  /// Creates a standard Mechanix linear progress indicator (4px height).
  const MechanixLinearProgressIndicator({
    super.key,
    this.value,
    this.size = MechanixProgressIndicatorSize.standard,
    this.minHeight,
    this.color,
    this.backgroundColor,
    this.valueColor,
    this.borderRadius,
    this.semanticsLabel,
    this.semanticsValue,
    this.theme,
  });

  /// Creates a large Mechanix linear progress indicator (8px height).
  const MechanixLinearProgressIndicator.large({
    super.key,
    this.value,
    this.minHeight,
    this.color,
    this.backgroundColor,
    this.valueColor,
    this.borderRadius,
    this.semanticsLabel,
    this.semanticsValue,
    this.theme,
  }) : size = MechanixProgressIndicatorSize.large;

  /// If non-null, the value of this progress indicator with 0.0 representing
  /// no progress and 1.0 representing completion.
  ///
  /// If null, this progress indicator is indeterminate and displays a continuous
  /// horizontal animation.
  final double? value;

  /// The size variant of this progress indicator.
  final MechanixProgressIndicatorSize size;

  /// The minimum height of the progress indicator.
  ///
  /// Defaults to 4.0 for [MechanixProgressIndicatorSize.standard] and
  /// 8.0 for [MechanixProgressIndicatorSize.large].
  final double? minHeight;

  /// The color of the active progress bar.
  ///
  /// Defaults to [ProgressIndicatorThemeDataConfig.linearProgressColor] or
  /// [ColorScheme.onSurfaceVariant].
  final Color? color;

  /// The color of the background track.
  ///
  /// Defaults to [ProgressIndicatorThemeDataConfig.linearTrackColor] or
  /// [ColorScheme.secondaryContainer].
  final Color? backgroundColor;

  /// The progress indicator's color as an animated value.
  ///
  /// If non-null, overrides [color].
  final Animation<Color?>? valueColor;

  /// The border radius applied to both the track and the indicator.
  ///
  /// Defaults to [BorderRadius.circular(height / 2)] (capsule shape).
  final BorderRadiusGeometry? borderRadius;

  /// The [SemanticsProperties.label] for this progress indicator.
  final String? semanticsLabel;

  /// The [SemanticsProperties.value] for this progress indicator.
  final String? semanticsValue;

  /// Custom theme override for this progress indicator instance.
  final ProgressIndicatorThemeDataConfig? theme;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeConfig = theme ?? MechanixProgressIndicatorTheme.of(context);

    final isLarge = size == MechanixProgressIndicatorSize.large;
    final effectiveHeight =
        minHeight ??
        (isLarge
            ? (themeConfig.largeLinearHeight ?? 8.0)
            : (themeConfig.standardLinearHeight ?? 4.0));
    final effectiveBorderRadius =
        borderRadius ??
        themeConfig.linearBorderRadius ??
        BorderRadius.circular(effectiveHeight / 2.0);
    final effectiveTrackColor =
        backgroundColor ??
        themeConfig.linearTrackColor ??
        colorScheme.secondaryContainer;
    final effectiveProgressColor =
        color ??
        themeConfig.linearProgressColor ??
        colorScheme.onSurfaceVariant;

    return LinearProgressIndicator(
      value: value,
      backgroundColor: effectiveTrackColor,
      color: effectiveProgressColor,
      valueColor: valueColor,
      minHeight: effectiveHeight,
      borderRadius: effectiveBorderRadius,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
    );
  }
}
