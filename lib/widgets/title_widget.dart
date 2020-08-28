import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleWidget extends StatelessWidget {
  int size; // 字体大小
  Color color; // 字体颜色
  String title; //  文本值
  FontWeight fontWeight; // 粗体
  EdgeInsets padding;

  TitleWidget({this.size, this.color, @required this.title, this.fontWeight,this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:padding ?? EdgeInsets.fromLTRB(20, 5, 20, 0),
      alignment: Alignment.topLeft,
      child: Text(
        title,
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(size ?? 50),
          color: color ?? Colors.black38,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
      ),
    );
  }
}
