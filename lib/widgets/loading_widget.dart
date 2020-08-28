import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: ScreenUtil().setHeight(500),
      width: ScreenUtil().setWidth(1440),
      child: Center(
        child: Image.asset("assets/images/loading.gif"),
      ),
    );;
  }
}
