import 'package:betz_cars/landing.dart';
import 'package:betz_cars/signin.dart';
import 'package:betz_cars/signup.dart';
import 'package:flutter/material.dart';
import 'overview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpruecheButton APP',
      color: Colors.black12,
      routes: {
        '/': (context) => Landing(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/overview': (context) => Overview(),
      },
    );
  }
}
