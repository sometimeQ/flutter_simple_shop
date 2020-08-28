import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import './fluro/NavigatorUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//加载页面
class LoadingPage extends StatefulWidget {
  @override
  _LoadingState createState() => new _LoadingState();
}

class _LoadingState extends State<LoadingPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _token;

  void _setToken() async {
    await _prefs.then((SharedPreferences values) {
      String token = values.getString('token') ?? '';
      _token = token;
      if (token == '') {
        NavigatorUtil.gotoHomePage(context);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setToken();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/1.jpg'), fit: BoxFit.cover)),
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Text("登入"),
                onPressed: () {},
                color: Colors.green,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),

              ),
              FlatButton(
                child: Text("注册"),
                onPressed: () {},
                color: Colors.white,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
