import 'package:flutter_test/flutter_test.dart';
import 'package:quickmove/main.dart';

void main() {
  testWidgets('QuickMove app loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const QuickMoveApp());

    expect(find.text('QuickMove'), findsOneWidget);
    expect(find.text('Get OTP & Continue'), findsOneWidget);
  });
}
