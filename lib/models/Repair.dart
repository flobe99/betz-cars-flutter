import 'dart:convert';
import 'dart:ffi';

List<Repair> repairModelFromJson(String str) =>
    List<Repair>.from(json.decode(str).map((x) => Repair.fromJson(x)));

String repairModelToJson(List<Repair> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Repair {
  Repair({
    required this.id,
    required this.summary,
    required this.date,
    required this.workshop,
    required this.costs,
    required this.kilometer,
  });

  String id;
  String summary;
  DateTime date;
  String workshop;
  double costs;
  int kilometer;

  factory Repair.fromJson(Map<String, dynamic> json) {
    return Repair(
      id: json['_id']['\$oid'],
      summary: json['summary'] is String ? json['summary'] : "",
      date: json['date']['\$date'] is String
          ? DateTime.parse(json['date']['\$date'])
          : DateTime.now(),
      workshop: json['workshop'] is String ? json['workshop'] : "",
      costs: json['costs'] is double ? json['costs'] : 0,
      kilometer: json['kilometer'] is int ? json['kilometer'] : 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'summary': summary,
        'date': date,
        'workshop': workshop,
        'costs': costs,
        'kilometer': kilometer,
      };
}
