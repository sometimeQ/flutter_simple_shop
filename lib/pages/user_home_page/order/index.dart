import 'package:demo1/fluro/NavigatorUtil.dart';
import 'package:demo1/pages/user_home_page/widgets/svg_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fsuper/fsuper.dart';

class OrderIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(300),
        width: ScreenUtil().setWidth(1300),
        margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(70),
            right: ScreenUtil().setWidth(70),
            top: ScreenUtil().setHeight(40)
        ),
        padding: EdgeInsets.symmetric( horizontal: ScreenUtil().setWidth(70)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: (){
                NavigatorUtil.gotoOrderAllIndexPage(context, "-1"); // -1表示全部显示
              },
              child: SvgTitle(title:"全部订单",
                  svgPath:"assets/svg/order.svg"),
            ),
            SvgTitle(title:"已通过",svgPath:"assets/svg/order2.svg"),
            SvgTitle(title:"等待审核",svgPath:"assets/svg/order3.svg"),
            SvgTitle(title:"无效订单",svgPath:"assets/svg/order4.svg"),
          ],
        ));
  }

}
