import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpDownBtnWidget extends StatelessWidget {

  bool isCur;
  String upText;
  String downText;
  UpDownBtnWidget({this.isCur,this.downText,this.upText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: isCur
            ? Color.fromRGBO(254, 62, 59, 1.0)
            : Color.fromRGBO(248, 248, 248, 1.0),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
      margin: EdgeInsets.only(right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(upText,
              style: TextStyle(
                  color: isCur ? Colors.white : Colors.black38,
                  fontSize: ScreenUtil().setSp(45))),
          Text(downText,
              style: TextStyle(
                  color: isCur ? Colors.white : Colors.black38,
                  fontSize: ScreenUtil().setSp(30)))
        ],
      ),
    );
  }
}
