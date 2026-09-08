import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets/widgets.dart';

void main() {
  group('MechanixIcons Tests', () {
    test('MechanixIcons defines expected glyphs and font family', () {
      expect(MechanixIcons.iconFontFamily, equals('MechanixIcons'));
      expect(MechanixIcons.iconFontPackage, equals('widgets'));

      expect(MechanixIcons.caretLeft.codePoint, equals(0xe000));
      expect(MechanixIcons.comet.codePoint, equals(0xe001));
    });

    testWidgets('MechanixIcons renders in an Icon widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Icon(MechanixIcons.comet),
        ),
      );

      expect(find.byType(Icon), findsOneWidget);
    });
  });
}
