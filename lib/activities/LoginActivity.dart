// ignore: avoid_web_libraries_in_flutter

//import 'dart:html';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rajuk_flutter/activities/PhaseActivity.dart';
import 'package:rajuk_flutter/activities/ProjectActivity.dart';
import 'package:rajuk_flutter/activities/TestActivity.dart';
import 'package:rajuk_flutter/color/CustomColors.dart';
import 'package:rajuk_flutter/utilities/StaticAccess.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MaterialApp(
      title: 'Professional Rajuk App',
      theme: ThemeData(
        primaryColor: RajukColor,
      ),
      home: LoginActivity()));

  await Firebase.initializeApp();
}

class LoginActivity extends StatefulWidget {
  @override
  _LoginActivityState createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  var formKey = GlobalKey<FormState>();
  var nameControler = TextEditingController();
  var passwordControler = TextEditingController();
  var name, password;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    initializeValue();
  }

  initializeValue() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
        backgroundColor: RajukColor,
        body: Center(
          child: Container(
            width: 400,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/rajuk_logo.png',
                      ),
                      Divider(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'User name ',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: nameControler,
                        validator: (value) {
                          if (value.length == 0) return 'User name is required';
                          name = value;
                        },
                        onSaved: (userSavedValue) {
                          name = userSavedValue;
                        },
                      ),
                      Divider(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: password,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: passwordControler,
                        validator: (value) {
                          if (value.length == 0) return 'password required';
                          password = value;
                        },
                        onSaved: (userPasswordValue) {
                          password = userPasswordValue;
                        },
                      ),
                      Divider(
                        height: 10,
                      ),
                      RaisedButton(
                        child: Text('Login'),
                        onPressed: () {
                          login();
                        },
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }

  login() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print('Rokan User Name: $name');
      print('Rokan Password : $password');

      setState(() {
        sharedPreferences.setString(StaticAccess.TAG_USER_NAME, '$name');
        sharedPreferences.setString(StaticAccess.TAG_PASSWORD, '$password');
      });

      Route route = MaterialPageRoute(builder: (context) => ProjectActivity());
      Navigator.push(context, route);
    }
  }
}

//Image.asset("assets/images/rajuk_logo.png"),
