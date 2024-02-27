import 'package:betz_cars/controller/UserApi.dart';
import 'package:betz_cars/models/User.dart';
import 'package:betz_cars/signup.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  bool passwordVisible = true;
  int status_code = -1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _controller_Username = TextEditingController();
  TextEditingController _controller_Password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<int> _user_signin(data) async {
    int pStatus_code = await UserApi().user_signin(data);
    print("_user_signin status_code: " + status_code.toString());
    /*Future.delayed(const Duration(seconds: 3)).then((value) => setState(() {
          print(value);
        }));*/
    setState(() {
      status_code = pStatus_code;
    });
    return status_code;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(16, 78, 138, 1),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 200),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Image.asset("assets/betz-group-no-background.png"),
                ),
                Container(
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 40,
                      color: Color.fromRGBO(16, 78, 138, 1),
                    ),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid username';
                    }
                    return null;
                  },
                  controller: _controller_Username,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: "username",
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid passwort';
                    }
                    return null;
                  },
                  controller: _controller_Password,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "password",
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(
                          () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      },
                    ),
                    alignLabelWithHint: false,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color?>(
                          Color.fromRGBO(16, 78, 138, 1)),
                      fixedSize:
                          MaterialStateProperty.all<Size?>(Size(200.0, 5.0)),
                      textStyle: MaterialStateProperty.all<TextStyle?>(
                          TextStyle(fontSize: 20)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        User data = new User(
                            id: "",
                            username: _controller_Username.text,
                            password: _controller_Password.text);

                        if (await UserApi().user_signin(data) == 200) {
                          print("successful");
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(
                              "username", _controller_Username.text);
                          Navigator.pushNamedAndRemoveUntil(context,
                              '/overview', ModalRoute.withName('/overview'));
                        } else {
                          print("not successful");
                          //showInSnackBar('Incorrect credentials');
                        }
                      }
                    },
                    child: Text("Sign In"),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    child: GestureDetector(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(16, 78, 138, 1)),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
