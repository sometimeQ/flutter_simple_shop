import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TagWidget extends StatelessWidget {
  String title;
  Color bg;
  Color textColor;
  bool noBorder;

  TagWidget({this.title, this.bg, this.textColor,this.noBorder});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(600),
      padding: EdgeInsets.all(1.0),
      margin: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
          color: bg ?? Colors.white,
          border:!noBorder ? Border.all(width: 1.0,color: textColor??Colors.black26):Border(),
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Text(title, style: TextStyle(color: textColor ?? Colors.black26),maxLines: 1,overflow: TextOverflow.ellipsis),
    );
  }
}
