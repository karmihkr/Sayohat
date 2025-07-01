import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/screens/tabs-main-screens/find-ride-screens/find_data.dart';

void main() {
  test('DataSearch.empty() should initialize empty string', () {
    final dataSearch = DataSearch.empty();

    expect(dataSearch.from, '');
    expect(dataSearch.to, '');
    expect(dataSearch.date, '');
    expect(dataSearch.passengers, '');
  });
}
