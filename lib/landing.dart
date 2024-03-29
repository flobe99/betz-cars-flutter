import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String _username = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _username = (prefs.getString('username') ?? "");
    if (_username == "") {
      //Navigator.pushNamed(context, '/login');
      Navigator.pushNamedAndRemoveUntil(
          context, '/signin', ModalRoute.withName('/signin'));
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/overview', ModalRoute.withName('/overview'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
