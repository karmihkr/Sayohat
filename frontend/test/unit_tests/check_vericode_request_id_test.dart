import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/api_client.dart';

void main() {
  final client = APIClient();
  test('vericodeRequestId returns "unsent" for invalid number', () async {
    final result = await client.vericodeRequestId('invalid-number');
    expect(result, 'unsent');
  });
}
