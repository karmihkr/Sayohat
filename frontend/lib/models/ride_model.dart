class Ride {
  final String id;
  final String driverId;
  final String fromCity;
  final String toCity;
  final String date;
  final String time;
  final int seats;
  final String cost;
  final String addressFrom;
  final String addressTo;
  final String description;
  final String carModel;
  final String carColor;
  final String carPlate;

  Ride({
    required this.id,
    required this.driverId,
    required this.fromCity,
    required this.toCity,
    required this.date,
    required this.time,
    required this.seats,
    required this.cost,
    required this.addressFrom,
    required this.addressTo,
    required this.description,
    required this.carModel,
    required this.carColor,
    required this.carPlate,
  });
  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'].toString(),
      driverId: json['driver_id'].toString(),
      fromCity: json['from'] as String,
      toCity: json['to'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      seats: int.parse(json['available_places'].toString()),
      cost: json['price'].toString(),
      addressFrom: json['address1'] as String,
      addressTo: json['address2'] as String,
      description: json['description'] as String,
      carModel: json['car_model'] as String,
      carColor: json['car_color'] as String,
      carPlate: json['car_plate'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driver_id': driverId,
      'from': fromCity,
      'to': toCity,
      'date': date,
      'time': time,
      'available_places': seats,
      'price': cost,
      'address1': addressFrom,
      'address2': addressTo,
      'description': description,
      'car_model': carModel,
      'car_color': carColor,
      'car_plate': carPlate,
    };
  }
}
