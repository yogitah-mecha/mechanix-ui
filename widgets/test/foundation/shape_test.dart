import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('ShapeTheme Tests', () {
    test('ShapeTheme.standard has correct default values', () {
      final standard = ShapeTheme.standard();

      expect(standard.none, equals(BorderRadius.zero));
      expect(standard.extraSmall, equals(BorderRadius.circular(4)));
      expect(standard.small, equals(BorderRadius.circular(8)));
      expect(standard.medium, equals(BorderRadius.circular(12)));
      expect(standard.large, equals(BorderRadius.circular(16)));
      expect(standard.full, equals(BorderRadius.circular(1000)));
    });

    test('ShapeTheme lerps between values smoothly', () {
      final shapeA = ShapeTheme.standard();
      final shapeB = shapeA.copyWith(none: BorderRadius.circular(10));
      final interpolated = shapeA.lerp(shapeB, 0.5);

      expect(interpolated.none, equals(BorderRadius.circular(5)));
    });
  });
}
