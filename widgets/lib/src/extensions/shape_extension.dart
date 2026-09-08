import 'package:flutter/material.dart';
import 'package:widgets/src/foundation/shape/shape_theme.dart';

extension ShapeExtension on BuildContext {
  ShapeTheme get shape {
    final shape = Theme.of(this).extension<ShapeTheme>();
    return shape ?? ShapeTheme.standard();
  }
}
