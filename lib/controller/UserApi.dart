//import 'dart:developer';
import 'package:betz_cars/controller/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  Future<int> user_signin(data) async {
    var request = {
      "username": data.username,
      "password": data.password,
    };
    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(Uri.parse(REST_API_URL + '/users/signin'),
        headers: headers, body: json.encode(request));

    return response.statusCode;
  }
}
