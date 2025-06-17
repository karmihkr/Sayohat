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
  final Date date;
  final int seats;
  final String address1;
  final String address2;
  final int cost;
  final String description;
  final String carModel;
  final String carColor;
  final String carPlate;

  Ride({
    required this.fullName,
    required this.age,
    required this.from,
    required this.to,
    required this.date,
    required this.seats,
    required this.address1,
    required this.address2,
    required this.cost,
    required this.description,
    required this.carModel,
    required this.carColor,
    required this.carPlate,
  });
}

final rides = [
  Ride(
    fullName: "Mark Perets",
    age: 30,
    from: 'Moscow',
    to: 'Innopolis',
    date: Date(day: 10, month: 10, year: 2025, hour: 21, min: 45),
    seats: 3,
    address1: 'Lenina Street 1',
    address2: 'Universitetskaya street 1',
    cost: 1000,
    description: '@alias',
    carModel: "Daewoo Nexia",
    carColor: "Gold",
    carPlate: 'T995YT777',
  ),
  Ride(
    fullName: "Ivan Alekseev",
    age: 30,
    from: 'Moscow',
    to: 'Innopolis',
    date: Date(day: 10, month: 10, year: 2025, hour: 21, min: 45),
    seats: 3,
    address1: 'Pushkina Street 1',
    address2: 'Sportivnaya street 1',
    cost: 1000,
    description: '@alias',
    carModel: "Lada Granda",
    carColor: "White",
    carPlate: 'T498YT97',
  ),
  Ride(
    fullName: "Arsentiy Schekin",
    age: 30,
    from: 'Moscow',
    to: 'Innopolis',
    date: Date(day: 10, month: 10, year: 2025, hour: 21, min: 45),
    seats: 3,
    address1: 'Poker Street 1',
    address2: 'Universitetskaya street 1k5 room 107',
    cost: 1000,
    description: '@alias',
    carModel: "Cherry tygo pro max ultra plus minus 999",
    carColor: "Purple",
    carPlate: 'D005RN107',
  ),
  Ride(
    fullName: "Uha Uhahahhahaha",
    age: 30,
    from: 'Moscow',
    to: 'Innopolis',
    date: Date(day: 10, month: 10, year: 2025, hour: 21, min: 45),
    seats: 3,
    address1: 'Rybnaya Street 1',
    address2: 'Universitetskaya street 5',
    cost: 1000,
    description: '@alias',
    carModel: "Lada Niva",
    carColor: "Gold",
    carPlate: 'T485YT57',
  ),
];

//final rides = [];
