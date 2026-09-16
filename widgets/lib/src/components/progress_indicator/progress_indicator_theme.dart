import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Theme configuration for [MechanixCircularProgressIndicator] and
/// [MechanixLinearProgressIndicator].
///
/// Can be provided globally via [ThemeData.extensions] or scoped using
/// [MechanixProgressIndicatorTheme].
@immutable
class ProgressIndicatorThemeDataConfig
    extends ThemeExtension<ProgressIndicatorThemeDataConfig>
    with Diagnosticable {
  const ProgressIndicatorThemeDataConfig({
    this.circularTrackColor,
    this.circularProgressColor,
    this.circularStrokeCap,
    this.standardCircularSize,
    this.standardCircularStrokeWidth,
    this.largeCircularSize,
    this.largeCircularStrokeWidth,
    this.linearTrackColor,
    this.linearProgressColor,
    this.standardLinearHeight,
    this.largeLinearHeight,
    this.linearBorderRadius,
  });

  /// The background track color for circular progress indicators.
  final Color? circularTrackColor;

  /// The active progress color for circular progress indicators.
  final Color? circularProgressColor;

  /// The stroke cap style for circular progress indicators.
  final StrokeCap? circularStrokeCap;

  /// Dimension (width and height) for standard circular progress indicators.
  final double? standardCircularSize;

  /// Stroke width for standard circular progress indicators.
  final double? standardCircularStrokeWidth;

  /// Dimension (width and height) for large circular progress indicators.
  final double? largeCircularSize;

  /// Stroke width for large circular progress indicators.
  final double? largeCircularStrokeWidth;

  /// The background track color for linear progress indicators.
  final Color? linearTrackColor;

  /// The active progress color for linear progress indicators.
  final Color? linearProgressColor;

  /// Height for standard linear progress indicators.
  final double? standardLinearHeight;

  /// Height for large linear progress indicators.
  final double? largeLinearHeight;

  /// Corner radius for linear progress indicators.
  final BorderRadiusGeometry? linearBorderRadius;

  @override
  ProgressIndicatorThemeDataConfig copyWith({
    Color? circularTrackColor,
    Color? circularProgressColor,
    StrokeCap? circularStrokeCap,
    double? standardCircularSize,
    double? standardCircularStrokeWidth,
    double? largeCircularSize,
    double? largeCircularStrokeWidth,
    Color? linearTrackColor,
    Color? linearProgressColor,
    double? standardLinearHeight,
    double? largeLinearHeight,
    BorderRadiusGeometry? linearBorderRadius,
  }) {
    return ProgressIndicatorThemeDataConfig(
      circularTrackColor: circularTrackColor ?? this.circularTrackColor,
      circularProgressColor:
          circularProgressColor ?? this.circularProgressColor,
      circularStrokeCap: circularStrokeCap ?? this.circularStrokeCap,
      standardCircularSize: standardCircularSize ?? this.standardCircularSize,
      standardCircularStrokeWidth:
          standardCircularStrokeWidth ?? this.standardCircularStrokeWidth,
      largeCircularSize: largeCircularSize ?? this.largeCircularSize,
      largeCircularStrokeWidth:
          largeCircularStrokeWidth ?? this.largeCircularStrokeWidth,
      linearTrackColor: linearTrackColor ?? this.linearTrackColor,
      linearProgressColor: linearProgressColor ?? this.linearProgressColor,
      standardLinearHeight: standardLinearHeight ?? this.standardLinearHeight,
      largeLinearHeight: largeLinearHeight ?? this.largeLinearHeight,
      linearBorderRadius: linearBorderRadius ?? this.linearBorderRadius,
    );
  }

  /// Merges another [ProgressIndicatorThemeDataConfig] into this configuration.
  ProgressIndicatorThemeDataConfig merge(
    ProgressIndicatorThemeDataConfig? other,
  ) {
    if (other == null) return this;
    return copyWith(
      circularTrackColor: other.circularTrackColor,
      circularProgressColor: other.circularProgressColor,
      circularStrokeCap: other.circularStrokeCap,
      standardCircularSize: other.standardCircularSize,
      standardCircularStrokeWidth: other.standardCircularStrokeWidth,
      largeCircularSize: other.largeCircularSize,
      largeCircularStrokeWidth: other.largeCircularStrokeWidth,
      linearTrackColor: other.linearTrackColor,
      linearProgressColor: other.linearProgressColor,
      standardLinearHeight: other.standardLinearHeight,
      largeLinearHeight: other.largeLinearHeight,
      linearBorderRadius: other.linearBorderRadius,
    );
  }

  @override
  ProgressIndicatorThemeDataConfig lerp(
    ThemeExtension<ProgressIndicatorThemeDataConfig>? other,
    double t,
  ) {
    if (other is! ProgressIndicatorThemeDataConfig) return this;
    return ProgressIndicatorThemeDataConfig(
      circularTrackColor: Color.lerp(
        circularTrackColor,
        other.circularTrackColor,
        t,
      ),
      circularProgressColor: Color.lerp(
        circularProgressColor,
        other.circularProgressColor,
        t,
      ),
      circularStrokeCap:
          t < 0.5 ? circularStrokeCap : other.circularStrokeCap,
      standardCircularSize: lerpDouble(
        standardCircularSize,
        other.standardCircularSize,
        t,
      ),
      standardCircularStrokeWidth: lerpDouble(
        standardCircularStrokeWidth,
        other.standardCircularStrokeWidth,
        t,
      ),
      largeCircularSize: lerpDouble(
        largeCircularSize,
        other.largeCircularSize,
        t,
      ),
      largeCircularStrokeWidth: lerpDouble(
        largeCircularStrokeWidth,
        other.largeCircularStrokeWidth,
        t,
      ),
      linearTrackColor: Color.lerp(
        linearTrackColor,
        other.linearTrackColor,
        t,
      ),
      linearProgressColor: Color.lerp(
        linearProgressColor,
        other.linearProgressColor,
        t,
      ),
      standardLinearHeight: lerpDouble(
        standardLinearHeight,
        other.standardLinearHeight,
        t,
      ),
      largeLinearHeight: lerpDouble(
        largeLinearHeight,
        other.largeLinearHeight,
        t,
      ),
      linearBorderRadius: BorderRadiusGeometry.lerp(
        linearBorderRadius,
        other.linearBorderRadius,
        t,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('circularTrackColor', circularTrackColor));
    properties.add(
      ColorProperty('circularProgressColor', circularProgressColor),
    );
    properties.add(
      DiagnosticsProperty<StrokeCap>('circularStrokeCap', circularStrokeCap),
    );
    properties.add(
      DoubleProperty('standardCircularSize', standardCircularSize),
    );
    properties.add(
      DoubleProperty(
        'standardCircularStrokeWidth',
        standardCircularStrokeWidth,
      ),
    );
    properties.add(DoubleProperty('largeCircularSize', largeCircularSize));
    properties.add(
      DoubleProperty('largeCircularStrokeWidth', largeCircularStrokeWidth),
    );
    properties.add(ColorProperty('linearTrackColor', linearTrackColor));
    properties.add(ColorProperty('linearProgressColor', linearProgressColor));
    properties.add(DoubleProperty('standardLinearHeight', standardLinearHeight));
    properties.add(DoubleProperty('largeLinearHeight', largeLinearHeight));
    properties.add(
      DiagnosticsProperty<BorderRadiusGeometry>(
        'linearBorderRadius',
        linearBorderRadius,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProgressIndicatorThemeDataConfig &&
        other.circularTrackColor == circularTrackColor &&
        other.circularProgressColor == circularProgressColor &&
        other.circularStrokeCap == circularStrokeCap &&
        other.standardCircularSize == standardCircularSize &&
        other.standardCircularStrokeWidth == standardCircularStrokeWidth &&
        other.largeCircularSize == largeCircularSize &&
        other.largeCircularStrokeWidth == largeCircularStrokeWidth &&
        other.linearTrackColor == linearTrackColor &&
        other.linearProgressColor == linearProgressColor &&
        other.standardLinearHeight == standardLinearHeight &&
        other.largeLinearHeight == largeLinearHeight &&
        other.linearBorderRadius == linearBorderRadius;
  }

  @override
  int get hashCode {
    return Object.hash(
      circularTrackColor,
      circularProgressColor,
      circularStrokeCap,
      standardCircularSize,
      standardCircularStrokeWidth,
      largeCircularSize,
      largeCircularStrokeWidth,
      linearTrackColor,
      linearProgressColor,
      standardLinearHeight,
      largeLinearHeight,
      linearBorderRadius,
    );
  }
}

/// An inherited theme that defines visual properties for
/// [MechanixCircularProgressIndicator] and [MechanixLinearProgressIndicator]
/// within a subtree.
class MechanixProgressIndicatorTheme extends InheritedTheme {
  const MechanixProgressIndicatorTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The configuration applied to descendent progress indicators.
  final ProgressIndicatorThemeDataConfig data;

  /// Returns the nearest [ProgressIndicatorThemeDataConfig] up the widget tree,
  /// or a default instance if none is found.
  static ProgressIndicatorThemeDataConfig of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<MechanixProgressIndicatorTheme>();
    return theme?.data ??
        Theme.of(context).extension<ProgressIndicatorThemeDataConfig>() ??
        const ProgressIndicatorThemeDataConfig();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MechanixProgressIndicatorTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(MechanixProgressIndicatorTheme oldWidget) {
    return data != oldWidget.data;
  }
}
