import 'dart:convert';

class User {
  String? id;
  String? name;
  String? surname;
  int? year;
  int? month;
  int? day;
  String? phone;
  int? asDriver;
  int? asPassenger;

  User({
    this.id,
    this.name,
    this.surname,
    this.year,
    this.month,
    this.day,
    this.phone,
    this.asDriver,
    this.asPassenger
  });

  factory User.fromJsonString(String? jsonString) {
    final json = jsonDecode(jsonString!);
    return User(
      id: json["_id"],
      name: json["name"],
      surname: json["surname"],
      year: json["year"],
      month: json["month"],
      day: json["day"],
      phone: json["phone"],
      asDriver: json["as_driver"],
      asPassenger: json["as_passenger"]
    );
  }

  String toJsonString() {
    return jsonEncode({
      "_id": id,
      "name": name,
      "surname": surname,
      "year": year,
      "month": month,
      "day": day,
      "phone": phone,
      "as_driver": asDriver,
      "as_passenger": asPassenger
    });
  }
}
