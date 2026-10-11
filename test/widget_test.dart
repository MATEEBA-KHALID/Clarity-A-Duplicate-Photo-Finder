
import 'package:flutter_test/flutter_test.dart';
import 'package:clarity_a_duplicate_photo_finder/main.dart';

void main() {
  testWidgets('Clarity app launches', (WidgetTester tester) async {
    await tester.pumpWidget(const ClarityApp());

    expect(find.text('Clarity'), findsOneWidget);
  });
}

