import 'dart:convert';

List<Car> carModelFromJson(String str) =>
    List<Car>.from(json.decode(str).map((x) => Car.fromJson(x)));

String carModelToJson(List<Car> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Car {
  Car({
    required this.id,
    required this.producer,
    required this.modell,
    required this.year,
    required this.kilometers,
    required this.buying_price,
    required this.repair_costs,
    required this.customer_service,
    required this.oil_change,
    required this.next_inspection,
    required this.last_fuel,
  });

  String id;
  String producer;
  String modell;
  int year;
  int kilometers;
  int buying_price;
  int repair_costs;
  DateTime customer_service;
  DateTime oil_change;
  DateTime next_inspection;
  DateTime last_fuel;

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['_id']['\$oid'],
      producer: json['producer'] is String ? json['producer'] : "",
      modell: json['modell'] is String ? json['modell'] : "",
      year: json['year'] is int ? json['year'] : 0,
      kilometers: json['kilometer'] is int ? json['kilometer'] : 0,
      buying_price: json['buying-price'] is int ? json['buying-price'] : 0,
      repair_costs: json['repair-costs'] is int ? json['repair-costs'] : 0,
      customer_service: json['customer-service']['\$date'] is String
          ? DateTime.parse(json['customer-service']['\$date'])
          : DateTime.now(),
      oil_change: json['oil-change'] is String
          ? DateTime.parse(json['oil-change']['\$date'])
          : DateTime.now(),
      next_inspection: json['next-inspection'] is String
          ? DateTime.parse(json['next-inspection']['\$date'])
          : DateTime.now(),
      last_fuel: json['last_fuel'] is String
          ? DateTime.parse(json['last_fuel']['\$date'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'producer': producer,
        'modell': modell,
        'year': year,
        'kilometers': kilometers,
        'buying_price': buying_price,
        'repair_costs': repair_costs,
        'customer_service': customer_service,
        'oil_change': oil_change,
        'next_inspection': next_inspection,
      };
}
