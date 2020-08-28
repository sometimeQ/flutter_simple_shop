import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SvgTitle extends StatelessWidget {
  final String svgPath;
  final String title;
  final dynamic onTap;
  SvgTitle({this.title,this.svgPath,this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(300),
        width: ScreenUtil().setWidth(290),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              svgPath,
              width: ScreenUtil().setWidth(100),
              height: ScreenUtil().setHeight(100),
            ),
            SizedBox(height: ScreenUtil().setHeight(30)),
            Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(50)),)
          ],
        ),
      ),
    );
  }
}
