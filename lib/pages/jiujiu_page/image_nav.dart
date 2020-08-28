import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ImageNav extends StatelessWidget {
  Text title;
  Text subTitle;
  String src;
  dynamic onTap;
  int width;
  int height;

  ImageNav({this.title, this.subTitle, this.src, this.onTap,this.width,this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(width),
      height: ScreenUtil().setHeight(height),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: <Widget>[

            // 图片
            ExtendedImage.network(
              src,
              fit: BoxFit.cover,
              cache: true,
              width: ScreenUtil().setWidth(width),
              height: ScreenUtil().setHeight(height),
            ),

            Positioned(
              left: 5,
              top: 5,
              child: title,
            ),
            Positioned(
              left: 5,
              top: 25,
              child: subTitle,
            ),
          ],
        ),
      ),
    );
  }
}
