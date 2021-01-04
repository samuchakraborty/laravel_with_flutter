// Future<ElementOtp> createElement(String mobile, String otp) async {
//   final http.Response response = await http.post(
//     'https://test.anazbd.com/api/register',
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{"mobile": mobile, "otp": otp}),
//   );
//   var res = jsonDecode(response.body);

//   print(res["data"]["token"]);

//   //  return res["status"];
//   // return jsonDecode(response.body);

//   if (res["status"] == "success") {
//     //return Text("sucess");

//     print(res["data"]["token"]);
//     // return ElementOtp.fromJson(jsonDecode(response.body));
//     return res["data"].token;
//   } else {
//     throw Exception('Failed to create Element.');
//   }
// }

// class ElementOtp {
//   final String mobile;
//   final String otp;

//   ElementOtp({this.mobile, this.otp});

//   factory ElementOtp.fromJson(Map<String, dynamic> json) {
//     return ElementOtp(
//       mobile: json['mobile'],
//       otp: json['otp'],
//     );
//   }
// }

// class OtpPage extends StatelessWidget {
//   final mobileHolder;

//   final otp = TextEditingController();
//   OtpPage({
//     this.mobileHolder,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("hello")),
//       body: Container(
//         child: Column(children: [
//           Visibility(
//             visible: true,
//             child: Text("mobile: " + mobileHolder),
//           ),
//           TextField(
//             controller: otp,
//             decoration: InputDecoration(hintText: 'Enter Otp'),
//           ),
//           ElevatedButton(
//             child: Text('Create Data'),
//             onPressed: () {
//               // setState(() {
//               createElement(mobileHolder, otp.text);
//               //  print(_mobileController.text);

//               //});
//             },
//           ),
//         ]),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_register_with_laravel/network_utils/api.dart';
import 'package:login_register_with_laravel/screen/home.dart';

import 'package:login_register_with_laravel/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPage extends StatefulWidget {
  var mobile;
  OtpPage(String mobile) {
    this.mobile = mobile;
  }
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  // final mobile;
  var otp;
  // var mobile;
  //final mobileController = TextEditingController();
  // getItemAndNavigate(BuildContext context) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => OtpPage(
  //                 mobileHolder: mobilecontroller.text,
  //                 // emailHolder: mobile.text,
  //                 // passwordHolder: password.text,
  //               )));
  // }

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
                              // Visibility(
                              //   visible: true,
                              //   child: Text("mobile: " + mobile),
                              // ),
                              Text("mobile: " + widget.mobile),
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.grey,
                                  ),
                                  hintText: "OtpPage",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (passwordValue) {
                                  if (passwordValue.isEmpty) {
                                    return 'Please enter Otp';
                                  }
                                  otp = passwordValue;
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
                                      _otpPage();
                                      //    getItemAndNavigate(context);
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

  void _otpPage() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'mobile': widget.mobile,
      'otp': otp,
    };

    var res = await Network().authData(data, '/api/register');
    var body = json.decode(res.body);
    if (body['status'] == 'success') {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['data']['token']));
      //   localStorage.setString('msg', json.encode(body['msg']));
      localStorage.setString('data', json.encode(body['data']));

      print(json.encode(body['msg']));
     // print(json.encode(body['data']['token']));

      print(localStorage.getString('token'));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => Home()),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
