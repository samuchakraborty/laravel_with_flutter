import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_register_with_laravel/network_utils/api.dart';

import 'package:login_register_with_laravel/screen/login.dart';
import 'package:login_register_with_laravel/screen/otpPage.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var mobile;
  var password;
  var name;
  final mobilecontroller = TextEditingController();
  getItemAndNavigate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OtpPage(
                  mobileHolder: mobilecontroller.text,
                  // emailHolder: mobile.text,
                  // passwordHolder: password.text,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.teal,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 4.0,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                controller: mobilecontroller,
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Mobile",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (mobileValue) {
                                  if (mobileValue.isEmpty) {
                                    return 'Please enter mobile Number';
                                  } else if (mobileValue.length < 11) {
                                    return 'please enter valid number';
                                  }

                                  mobile = mobileValue;
                                  return null;
                                },
                              ),
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.insert_emoticon,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (nameValue) {
                                  if (nameValue.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  name = nameValue;
                                  return null;
                                },
                              ),
                              // TextFormField(
                              //   style: TextStyle(color: Color(0xFF000000)),
                              //   cursorColor: Color(0xFF9b9b9b),
                              //   keyboardType: TextInputType.text,
                              //   decoration: InputDecoration(
                              //     prefixIcon: Icon(
                              //       Icons.insert_emoticon,
                              //       color: Colors.grey,
                              //     ),
                              //     hintText: "Last Name",
                              //     hintStyle: TextStyle(
                              //         color: Color(0xFF9b9b9b),
                              //         fontSize: 15,
                              //         fontWeight: FontWeight.normal),
                              //   ),
                              //   validator: (lastname) {
                              //     if (lastname.isEmpty) {
                              //       return 'Please enter your last name';
                              //     }
                              //     lname = lastname;
                              //     return null;
                              //   },
                              // ),
                              // TextFormField(
                              //   style: TextStyle(color: Color(0xFF000000)),
                              //   cursorColor: Color(0xFF9b9b9b),
                              //   keyboardType: TextInputType.text,
                              //   decoration: InputDecoration(
                              //     prefixIcon: Icon(
                              //       Icons.phone,
                              //       color: Colors.grey,
                              //     ),
                              //     hintText: "Phone",
                              //     hintStyle: TextStyle(
                              //         color: Color(0xFF9b9b9b),
                              //         fontSize: 15,
                              //         fontWeight: FontWeight.normal),
                              //   ),
                              //   validator: (phonenumber) {
                              //     if (phonenumber.isEmpty) {
                              //       return 'Please enter phone number';
                              //     }
                              //     phone = phonenumber;
                              //     return null;
                              //   },
                              // ),
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (passwordValue) {
                                  if (passwordValue.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  password = passwordValue;
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 10, right: 10),
                                    child: Text(
                                      _isLoading
                                          ? 'Proccessing...'
                                          : 'Register',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  color: Colors.teal,
                                  disabledColor: Colors.grey,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _register();
                                      getItemAndNavigate(context);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => Login()));
                        },
                        child: Text(
                          'Already Have an Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'password': password,
      'mobile': mobile,
      'name': name,
    };

    var res = await Network().authData(data, '/api/send/otp');
    var body = json.decode(res.body);
    if (body['status'] == 'success') {
      //  SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString('token', json.encode(body['token']));
      //   localStorage.setString('msg', json.encode(body['msg']));
      // localStorage.setString('data', json.encode(body['data']));

      print(json.encode(body['msg']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => OtpPage()),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}