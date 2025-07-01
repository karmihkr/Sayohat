import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/screens/tabs-main-screens/find-ride-screens/find_data.dart';

void main() {
  test('DataSearch should correctly initialize with parameter', () {
    final dataSearch = DataSearch('Paris', 'London', '01/01/2023', '2');

    expect(dataSearch.from, 'Paris');
    expect(dataSearch.to, 'London');
    expect(dataSearch.date, '01/01/2023');
    expect(dataSearch.passengers, '2');
  });
}
