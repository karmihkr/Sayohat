import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/api_clients/hamsafar_api_client.dart';

void main() {
  final client = HamsafarApiClient();
  test('checkTokenActuality returns false if token is null', () async {
    final result = await client.checkTokenActuality(null);
    expect(result, false);
  });
}
