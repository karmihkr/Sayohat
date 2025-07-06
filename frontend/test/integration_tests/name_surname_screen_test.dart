import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/screens/registration-screens/name_surname_screen.dart';

void main() {
  testWidgets('Name and surname fields show', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: NameSurnameScreen()));

    expect(find.byKey(const Key('nameField')), findsOneWidget);
    expect(find.byKey(const Key('surnameField')), findsOneWidget);
  });
}
