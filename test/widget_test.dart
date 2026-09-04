import 'package:flutter_test/flutter_test.dart';

import 'package:mini_logistics_app/main.dart';

void main() {
  testWidgets('Login screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(const LogisticsApp());

    expect(find.text('QuickMove'), findsOneWidget);
    expect(find.text('Mobile Number'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });
}
