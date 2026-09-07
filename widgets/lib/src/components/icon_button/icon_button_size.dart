import 'package:flutter/material.dart';
import 'icon_button_enums.dart';

/// Resolved specifications (dimension, icon size, min tap target)
/// corresponding to a given [IconButtonSize].
class IconButtonSizeConfig {
  final double dimension;
  final double iconSize;
  final double minTapTargetSize;

  const IconButtonSizeConfig({
    required this.dimension,
    required this.iconSize,
    required this.minTapTargetSize,
  });

  factory IconButtonSizeConfig.of(BuildContext context, IconButtonSize size) {
    switch (size) {
      case IconButtonSize.xSmall:
        return const IconButtonSizeConfig(
          dimension: 32,
          iconSize: 20,
          minTapTargetSize: 48,
        );

      case IconButtonSize.small:
        return const IconButtonSizeConfig(
          dimension: 40,
          iconSize: 24,
          minTapTargetSize: 48,
        );

      case IconButtonSize.medium:
        return const IconButtonSizeConfig(
          dimension: 56,
          iconSize: 24,
          minTapTargetSize: 0,
        );

      case IconButtonSize.large:
        return const IconButtonSizeConfig(
          dimension: 72,
          iconSize: 30.86,
          minTapTargetSize: 0,
        );

      case IconButtonSize.xLarge:
        return const IconButtonSizeConfig(
          dimension: 96,
          iconSize: 32,
          minTapTargetSize: 0,
        );

      case IconButtonSize.twoXLarge:
        return const IconButtonSizeConfig(
          dimension: 136,
          iconSize: 40,
          minTapTargetSize: 0,
        );
    }
  }
}

/// Extension on [IconButtonSize] for convenient access to its specifications.
extension MechanixIconButtonSizeExtension on IconButtonSize {
  IconButtonSizeConfig spec(BuildContext context) {
    return IconButtonSizeConfig.of(context, this);
  }
}
