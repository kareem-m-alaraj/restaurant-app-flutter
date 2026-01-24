// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:restaurant/main.dart';

void main() {
  testWidgets('Restaurant app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app bar is present with the correct title.
    expect(find.text('Restaurant Name'), findsOneWidget);

    // Verify that key sections are present.
    expect(find.text('Popular Items'), findsOneWidget);
    expect(find.text('Menu Categories'), findsOneWidget);
    expect(find.text('Current Offers'), findsOneWidget);
    expect(find.text('Customer Reviews'), findsOneWidget);

    // Verify that quick access buttons are present.
    expect(find.text('Order Now'), findsOneWidget);
    expect(find.text('Reservations'), findsOneWidget);
    expect(find.text('Loyalty/Rewards'), findsOneWidget);
  });
}
