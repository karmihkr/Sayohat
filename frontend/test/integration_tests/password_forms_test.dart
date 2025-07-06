import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/screens/registration-screens/password_screen.dart';

void main() {
  testWidgets('Password forms', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PasswordScreen()));
    await tester.pumpAndSettle();

    expect(find.byKey(Key("FormCreation")), findsOneWidget);
    expect(find.byKey(Key("FormConfirm")), findsOneWidget);
  });
}
