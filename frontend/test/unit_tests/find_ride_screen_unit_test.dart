import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/screens/tabs-main-screens/find-ride-screens/find_ride_screen.dart';

void main() {
  testWidgets('FindRideScreen should render correct', (
    WidgetTester tester,
  ) async {
    bool showSearchList = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FindRideScreen(
            onShowSearchList: (show) => showSearchList = show,
          ),
        ),
      ),
    );

    expect(find.text('From'), findsOneWidget);
    expect(find.text('To'), findsOneWidget);
    expect(find.text('dd/mm/yyyy'), findsOneWidget);
    expect(find.text('Number of Passengers'), findsOneWidget);
    expect(find.text('Find a ride!'), findsOneWidget);
  });
}
