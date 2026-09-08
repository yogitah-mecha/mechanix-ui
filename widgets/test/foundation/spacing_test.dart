import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixSpacing Tests', () {
    test('MechanixSpacing tokens have correct numerical values', () {
      expect(MechanixSpacing.xxxSmall, equals(2.0));
      expect(MechanixSpacing.xxSmall, equals(4.0));
      expect(MechanixSpacing.xSmall, equals(8.0));
      expect(MechanixSpacing.small, equals(12.0));
      expect(MechanixSpacing.medium, equals(16.0));
      expect(MechanixSpacing.large, equals(20.0));
      expect(MechanixSpacing.xLarge, equals(24.0));
      expect(MechanixSpacing.xxLarge, equals(32.0));
      expect(MechanixSpacing.xxxLarge, equals(40.0));
      expect(MechanixSpacing.huge, equals(48.0));
      expect(MechanixSpacing.massive, equals(64.0));
    });

    test('MechanixSpacing standard insets match spacing scale', () {
      expect(MechanixSpacing.insetsXXS, equals(const EdgeInsets.all(4.0)));
      expect(MechanixSpacing.insetsXS, equals(const EdgeInsets.all(8.0)));
      expect(MechanixSpacing.insetsS, equals(const EdgeInsets.all(12.0)));
      expect(MechanixSpacing.insetsM, equals(const EdgeInsets.all(16.0)));
      expect(MechanixSpacing.insetsL, equals(const EdgeInsets.all(20.0)));
      expect(MechanixSpacing.insetsXL, equals(const EdgeInsets.all(24.0)));
      expect(MechanixSpacing.insetsXXL, equals(const EdgeInsets.all(32.0)));
    });
  });
}
