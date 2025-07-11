import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/api_clients/hamsafar_api_client.dart';

void main() {
  final client = HamsafarApiClient();
  test('vericodeRequestId returns "unsent" for invalid number', () async {
    final result = await client.sendTelegramVerificationCode('invalid-number');
    expect(result, 'unsent');
  });
}
