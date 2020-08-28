import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class NoDataWidget extends StatelessWidget {
  String title;
  NoDataWidget({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/images/no_data.png",width: ScreenUtil().setWidth(500)),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(title??"商品已下架或者删除"),
                )
              ],
            )),
      ),
    );
  }
}
