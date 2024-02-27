import 'dart:convert';

import 'package:betz_cars/controller/constant.dart';
import 'package:betz_cars/models/Repair.dart';
import 'package:http/http.dart' as http;
import 'package:realm/realm.dart';

class RepairApi {
  Future<List<Repair>?> getCarRepairs(carId) async {
    var url = Uri.parse(REST_API_URL + '/cars/repairs/${carId}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<Repair> _model = repairModelFromJson(response.body);
      return _model;
    }
    return null;
  }

  Future<List<Repair>?> getRepair() async {
    var url = Uri.parse(REST_API_URL + '/repairs');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<Repair> _model = repairModelFromJson(response.body);
      return _model;
    }
    return null;
  }

  Future<int> addFuel(data) async {
    var request = {
      "carId": data.carId,
      "kilometer": data.kilometer,
      "price_liter": data.price_liter,
      "amount_liter": data.amount_liter,
      "price": data.price,
      "date": data.date.toString()
    };
    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(
        Uri.parse(REST_API_URL + '/fuels/addfuels'),
        headers: headers,
        body: json.encode(request));

    return response.statusCode;
  }

  Future<int> updateFuel(id, data) async {
    var request = {
      "carId": data.carId,
      "kilometer": data.kilometer,
      "price_liter": data.price_liter,
      "amount_liter": data.amount_liter,
      "price": data.price,
      "date": data.date.toString()
    };
    final headers = {'Content-Type': 'application/json'};
    final response = await http.put(
        Uri.parse(REST_API_URL + '/fuels/updatefuels/${id}'),
        headers: headers,
        body: json.encode(request));

    return response.statusCode;
  }

  Future<void> deleteRepair(carId) async {
    final response = await http.delete(
      Uri.parse(REST_API_URL + '/repairs/deleteRepair/${carId}'),
    );
  }
}
