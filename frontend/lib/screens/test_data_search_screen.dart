class Date {
  final int day;
  final int month;
  final int year;
  final int hour;
  final int min;

  Date({
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.min,
  });
}

class Ride {
  final String fullName;
  final int age;
  final String from;
  final String to;
  final String address1;
  final String address2;
  final int seats;
  final int cost;
  final String description;
  final Date date;
  final String carPlate;

  Ride({
    required this.fullName,
    required this.age,
    required this.from,
    required this.to,
    required this.address1,
    required this.address2,
    required this.seats,
    required this.cost,
    required this.description,
    required this.date,
    required this.carPlate,
  });
}

final rides = [
  Ride(
    fullName: "Mark Perets",
    age: 30,
    from: 'Moscow',
    to: 'Innopolis',
    address1: 'Lenina Street 1',
    address2: 'Universitetskaya street 1',
    seats: 3,
    cost: 1000,
    description: '@alias',
    date: Date(day: 10, month: 10, year: 2025, hour: 21, min: 45),
    carPlate: 'T995YT777',
  ),
  Ride(
    fullName: "Aleksander Chupachups",
    age: 21,
    from: 'Moscow',
    to: 'Innopolis',
    address1: 'Sovetskaya Street 1',
    address2: 'Universitetskaya street 1',
    seats: 3,
    cost: 520,
    description: '@alias',
    date: Date(day: 12, month: 11, year: 2025, hour: 14, min: 30),
    carPlate: 'T995YT777',
  ),
  Ride(
    fullName: "Dmitri Lisiy",
    age: 24,
    from: 'Moscow',
    to: 'Innopolis',
    address1: 'Sovetskaya Street 1',
    address2: 'Universitetskaya street 1',
    seats: 3,
    cost: 1010,
    description: '@alias',
    date: Date(day: 14, month: 10, year: 2025, hour: 18, min: 30),
    carPlate: 'T995YT777',
  ),
  Ride(
    fullName: "Uha Uhahahaha",
    age: 52,
    from: 'Moscow',
    to: 'Innopolis',
    address1: 'Sovetskaya Street 1',
    address2: 'Universitetskaya street 1',
    seats: 3,
    cost: 890,
    description: '@alias',
    date: Date(day: 17, month: 10, year: 2025, hour: 19, min: 30),
    carPlate: 'T995YT777',
  ),
];
