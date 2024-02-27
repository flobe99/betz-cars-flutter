import 'dart:convert';

List<User> userModelFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userModelToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.id,
    required this.username,
    required this.password,
  });

  String id;
  String username;
  String password;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id']['\$oid'],
      username: json['username'] is String ? json['username'] : "",
      password: json['password'] is String ? json['password'] : "",
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
      };
}
