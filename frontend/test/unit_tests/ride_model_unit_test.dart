import 'package:flutter_test/flutter_test.dart';
import 'package:sayohat/screens/tabs-main-screens/add-ride-screens/your_ride_data.dart';

void main() {
  group('Ride Model Tests', () {
    test('Ride model should correctly initializing', () {
      final ride = Ride(
        fullName: 'John Doe',
        age: 30,
        from: 'New York',
        to: 'Boston',
        date: '01/01/2023',
        seats: '3',
        address1: '123 Main St',
        address2: '456 Oak Ave',
        time: '14:30',
        cost: '50',
        description: 'Comfortable ride',
        carModel: 'Toyota Camry',
        carColor: 'Blue',
        carPlate: 'ABC123',
      );

      expect(ride.fullName, 'John Doe');
      expect(ride.age, 30);
      expect(ride.from, 'New York');
      expect(ride.to, 'Boston');
      expect(ride.date, '01/01/2023');
      expect(ride.seats, '3');
      expect(ride.address1, '123 Main St');
      expect(ride.address2, '456 Oak Ave');
      expect(ride.time, '14:30');
      expect(ride.cost, '50');
      expect(ride.description, 'Comfortable ride');
      expect(ride.carModel, 'Toyota Camry');
      expect(ride.carColor, 'Blue');
      expect(ride.carPlate, 'ABC123');
    });
  });
}
