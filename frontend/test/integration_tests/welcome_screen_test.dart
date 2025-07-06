import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/welcome_screen.dart';

void main() {
  testWidgets('WelcomeScreen shows text and button', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));

    expect(find.textContaining('Welcome'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsWidgets);
  });
}
