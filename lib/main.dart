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
    return const MaterialApp(
      title: 'SpruecheButton APP',
      home: Overview(),
      color: Colors.black12,
    );
  }
}
