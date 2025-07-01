import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/screens/tabs-main-screens/add-ride-screens/add_ride_screen.dart';

void main() {
  testWidgets('AddRideScreen render and submit form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Material(child: AddRideScreen())),
    );

    expect(find.text('General'), findsOneWidget);
    expect(find.text('Ride details'), findsOneWidget);
    expect(find.text('Car information'), findsOneWidget);

    await tester.enterText(find.byKey(Key('departureCityField')), 'Moscow');
    await tester.enterText(find.byKey(Key('arrivalCityField')), 'Innopolis');
    await tester.enterText(find.byKey(Key('dateField')), "28/06/2025");
    await tester.enterText(find.byKey(Key('passengersField')), "3");
  });
}
