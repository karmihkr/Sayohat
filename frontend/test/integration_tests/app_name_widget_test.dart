import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/widgets/app_name.dart';

void main() {
  testWidgets('AppName shows correctly', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: AppName())));

    final textFinder = find.byType(Text);
    expect(textFinder, findsOneWidget);
  });
}
