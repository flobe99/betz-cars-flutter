//import 'dart:developer';
import 'package:betz_cars/models/constant.dart';
import 'package:http/http.dart' as http;
import 'package:betz_cars/models/Car.dart';

class CarApi {
  Future<List<Car>?> getCars() async {
    var url = Uri.parse(REST_API_URL + '/cars');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<Car> _model = carModelFromJson(response.body);
      print(_model);
      return _model;
    }
    return null;
  }
}
