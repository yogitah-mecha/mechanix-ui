import 'package:flutter/material.dart';

@immutable
class ShapeTheme extends ThemeExtension<ShapeTheme> {
  /// 0dp
  final BorderRadius none;

  /// 4dp
  final BorderRadius extraSmall;

  /// 8dp
  final BorderRadius small;

  /// 12dp
  final BorderRadius medium;

  /// 16dp
  final BorderRadius large;

  /// 20dp
  final BorderRadius largeIncreased;

  /// 28dp
  final BorderRadius extraLarge;

  /// 32dp
  final BorderRadius extraLargeIncreased;

  /// 48dp
  final BorderRadius extraExtraLarge;

  /// Fully rounded / pill shape.
  final BorderRadius full;

  const ShapeTheme({
    required this.none,
    required this.extraSmall,
    required this.small,
    required this.medium,
    required this.large,
    required this.largeIncreased,
    required this.extraLarge,
    required this.extraLargeIncreased,
    required this.extraExtraLarge,
    required this.full,
  });

  /// Default Material 3 shape scale.
  factory ShapeTheme.standard() {
    return const ShapeTheme(
      none: BorderRadius.zero,

      extraSmall: BorderRadius.all(
        Radius.circular(4),
      ),

      small: BorderRadius.all(
        Radius.circular(8),
      ),

      medium: BorderRadius.all(
        Radius.circular(12),
      ),

      large: BorderRadius.all(
        Radius.circular(16),
      ),

      largeIncreased: BorderRadius.all(
        Radius.circular(20),
      ),

      extraLarge: BorderRadius.all(
        Radius.circular(28),
      ),

      extraLargeIncreased: BorderRadius.all(
        Radius.circular(32),
      ),

      extraExtraLarge: BorderRadius.all(
        Radius.circular(48),
      ),

      // Use a large finite radius rather than infinity.
      full: BorderRadius.all(
        Radius.circular(1000),
      ),
    );
  }

  @override
  ShapeTheme copyWith({
    BorderRadius? none,
    BorderRadius? extraSmall,
    BorderRadius? small,
    BorderRadius? medium,
    BorderRadius? large,
    BorderRadius? largeIncreased,
    BorderRadius? extraLarge,
    BorderRadius? extraLargeIncreased,
    BorderRadius? extraExtraLarge,
    BorderRadius? full,
  }) {
    return ShapeTheme(
      none: none ?? this.none,
      extraSmall: extraSmall ?? this.extraSmall,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      largeIncreased: largeIncreased ?? this.largeIncreased,
      extraLarge: extraLarge ?? this.extraLarge,
      extraLargeIncreased: extraLargeIncreased ?? this.extraLargeIncreased,
      extraExtraLarge: extraExtraLarge ?? this.extraExtraLarge,
      full: full ?? this.full,
    );
  }

  @override
  ShapeTheme lerp(
    covariant ShapeTheme? other,
    double t,
  ) {
    if (other == null) {
      return this;
    }

    return ShapeTheme(
      none: BorderRadius.lerp(
        none,
        other.none,
        t,
      )!,
      extraSmall: BorderRadius.lerp(
        extraSmall,
        other.extraSmall,
        t,
      )!,
      small: BorderRadius.lerp(
        small,
        other.small,
        t,
      )!,
      medium: BorderRadius.lerp(
        medium,
        other.medium,
        t,
      )!,
      large: BorderRadius.lerp(
        large,
        other.large,
        t,
      )!,
      largeIncreased: BorderRadius.lerp(
        largeIncreased,
        other.largeIncreased,
        t,
      )!,
      extraLarge: BorderRadius.lerp(
        extraLarge,
        other.extraLarge,
        t,
      )!,
      extraLargeIncreased: BorderRadius.lerp(
        extraLargeIncreased,
        other.extraLargeIncreased,
        t,
      )!,
      extraExtraLarge: BorderRadius.lerp(
        extraExtraLarge,
        other.extraExtraLarge,
        t,
      )!,
      full: BorderRadius.lerp(
        full,
        other.full,
        t,
      )!,
    );
  }
}
