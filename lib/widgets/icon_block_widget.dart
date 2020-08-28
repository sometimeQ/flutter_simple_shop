import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconBlockWidget extends StatelessWidget {
  String desc;

  IconBlockWidget({this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10,bottom: 30),
      decoration: BoxDecoration(
          color: Color.fromRGBO(247, 248, 255, 1.0),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Stack(
        children: <Widget>[
          // 图标
          Positioned(
            child: Image.asset("assets/icons/dagou.png"),
            right: -40,
            top: -25,
          ),

          // 内容区
          Container(
            padding: EdgeInsets.all(18),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/icons/tuijian.png",
                      width: ScreenUtil().setWidth(55),
                      height: ScreenUtil().setHeight(55),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4.0),
                      child: Text(
                        "推荐理由",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text(
                    desc,
                    style: TextStyle(color: Colors.black38),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
