import 'dart:convert';

class Ride {
  String? id;
  String? driverName;
  String? driverSurname;
  String? driverPhone;
  String? fromCountry;
  String? fromCity;
  String? fromStreet;
  String? toCountry;
  String? toCity;
  String? toStreet;
  int? year;
  int? month;
  int? day;
  int? hours;
  int? minutes;
  int? passengers;
  double? price;
  String? description;
  String? carModel;
  String? carColor;
  String? carPlate;

  Ride({
    this.id,
    this.driverName,
    this.driverSurname,
    this.driverPhone,
    this.fromCountry,
    this.fromCity,
    this.fromStreet,
    this.toCountry,
    this.toCity,
    this.toStreet,
    this.year,
    this.month,
    this.day,
    this.hours,
    this.minutes,
    this.passengers,
    this.price,
    this.description,
    this.carModel,
    this.carColor,
    this.carPlate,
  });

  factory Ride.fromJsonString(String? jsonString) {
    final json = jsonDecode(jsonString!);
    return Ride(
      id: json["_id"],
      driverName: json["driver_name"],
      driverSurname: json["driver_surname"],
      driverPhone: json["driver_phone"],
      fromCountry: json["from_country"],
      fromCity: json["from_city"],
      fromStreet: json["from_street"],
      toCountry: json["to_country"],
      toCity: json["to_city"],
      toStreet: json["to_street"],
      year: json["year"],
      month: json["month"],
      day: json["day"],
      hours: json["hours"],
      minutes: json["minutes"],
      passengers: json["passengers"],
      price: json["price"],
      description: json["description"],
      carModel: json["car_model"],
      carColor: json["car_color"],
      carPlate: json["car_plate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "driver_name": driverName,
      "driver_surname": driverSurname,
      "driver_phone": driverPhone,
      "from_country": fromCountry,
      "from_city": fromCity,
      "from_street": fromStreet,
      "to_country": toCountry,
      "to_city": toCity,
      "to_street": toStreet,
      "year": year,
      "month": month,
      "day": day,
      "hours": hours,
      "minutes": minutes,
      "passengers": passengers,
      "price": price,
      "description": description,
      "car_model": carModel,
      "car_color": carColor,
      "car_plate": carPlate,
    };
  }
}
