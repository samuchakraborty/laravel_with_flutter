import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_register_with_laravel/network_utils/api.dart';
import 'package:login_register_with_laravel/screen/login.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name;
  String token;
  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var users = jsonDecode(localStorage.getString('data'));

    if (users != null) {
      setState(() {
        name = users['name'];
        token = users['token'];
      });
    } else if (users == null) {
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test App'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hi, $name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Hi, $token',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 4),
            ),
            RaisedButton(
              elevation: 10,
              onPressed: () {
                logout();
                print("on pressed");
              },
              color: Colors.teal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  void logout() async {
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    print(body);
    if (res.statusCode == 200) {
      print("on clicked");
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.remove(user);
      //localStorage.remove('token');
      localStorage.remove('token');
      localStorage.remove('data');
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      print(res.statusCode);
      print("not get");
    }
  }
}
