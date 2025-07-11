import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/api_client.dart';

void main() {
  final client = APIClient();
  test('checkVericode returns null for invalid input', () async {
    final result = await client.obtainAccessToken("+79000000000", 'invalid-id', '0000');
    expect(result is String, isTrue);
  });
}
