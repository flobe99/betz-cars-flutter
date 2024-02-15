import 'dart:convert';

import 'package:betz_cars/models/constant.dart';
import 'package:http/http.dart' as http;
import 'package:betz_cars/models/Fuel.dart';
import 'package:realm/realm.dart';

class FuelApi {
  Future<List<Fuel>?> getCarFuels(carId) async {
    print("carList Id: " + carId);
    var url = Uri.parse(REST_API_URL + '/cars/fuels/${carId}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<Fuel> _model = fuelModelFromJson(response.body);
      print(_model);
      return _model;
    }
    return null;
  }

  Future<List<Fuel>?> getFuel() async {
    var url = Uri.parse(REST_API_URL + '/fuels');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<Fuel> _model = fuelModelFromJson(response.body);
      print(_model);
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
    print("carList Id" + id);
    print("date: " + data.date.toString());
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

  Future<void> deleteFuel(carId) async {
    final response = await http.delete(
      Uri.parse(REST_API_URL + '/fuels/deleteFuel/${carId}'),
    );
  }
}
