import 'dart:convert';
import 'package:realm/realm.dart';

List<Fuel> fuelModelFromJson(String str) =>
    List<Fuel>.from(json.decode(str).map((x) => Fuel.fromJson(x)));

String fuelModelToJson(List<Fuel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Fuel {
  Fuel({
    required this.id,
    required this.carId,
    required this.kilometer,
    required this.price_liter,
    required this.amount_liter,
    required this.price,
    required this.date,
  });

  String id;
  String carId;
  int kilometer;
  double price_liter;
  double amount_liter;
  double price;
  DateTime date;

  factory Fuel.fromJson(Map<String, dynamic> json) {
    print("object");
    print(json['_id']['\$oid']);
    print(json['date']['\$date']);

    return Fuel(
      id: json['_id']['\$oid'],
      carId: json['_carId']['\$oid'],
      kilometer: json['kilometer'] is int ? json['kilometer'] : 0,
      price_liter: json['price_liter'] is double ? json['price_liter'] : 0,
      amount_liter: json['amount_liter'] is double ? json['amount_liter'] : 0,
      price: json['price'] is double ? json['price'] : "",
      date: json['date']['\$date'] is String
          ? DateTime.parse(json['date']['\$date'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        '_carId': carId,
        'kilometer': kilometer,
        'price_liter': price_liter,
        'amount_liter': amount_liter,
        'price': price,
        'date': date,
      };
}
