import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/widgets/app_logo.dart';

void main() {
  testWidgets('AppLogo shows correctly', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: AppLogo())));

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);

    final imageWidget = tester.widget<Image>(imageFinder);
    expect(imageWidget.width, 200);
  });
}
