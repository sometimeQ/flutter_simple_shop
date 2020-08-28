import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';

class ImageText extends SpecialText {
  static const String flag = "<img";
  final int start;
  final SpecialTextGestureTapCallback onTap;
  ImageText(TextStyle textStyle, {this.start, this.onTap})
      : super(ImageText.flag, "/>", textStyle);
  String _imageUrl;
  String get imageUrl => _imageUrl;
  @override
  InlineSpan finishText() {
    ///content already has endflag "/"
    var text = flag + getContent() + ">";
    ///"<img src='$url'/>"
//    var index1 = text.indexOf("'") + 1;
//    var index2 = text.indexOf("'", index1);
//
//    var url = text.substring(index1, index2);
//
    ////"<img src='$url' width='${item.imageSize.width}' height='${item.imageSize.height}'/>"
    var html = parse(text);

    var img = html.getElementsByTagName("img").first;
    var url = img.attributes["src"];
    _imageUrl = url;

    BoxFit fit = BoxFit.cover;

    double pmWidth = ScreenUtil().setWidth(1300);

    double height = double.tryParse(img.attributes["height"]);
    double width = double.tryParse(img.attributes["width"]);


    bool knowImageSize = true;
    if (knowImageSize) {
      double imgWidth = ScreenUtil().setWidth(width);
      double imgHeight = ScreenUtil().setHeight(height);
      if(imgWidth>pmWidth){
        double bl = pmWidth / pmWidth;
        height = imgHeight * bl;
        width = pmWidth;
      }else{
        height = imgHeight;
        width = imgWidth;
      }
    }

    return ExtendedWidgetSpan(
        start: start,
        actualText: text,
        child: Container(
          width: pmWidth,
          child: Center(
            child: GestureDetector(
                onTap: () {
                  onTap?.call(url);
                },
                child: ExtendedImage.network(url,
                    width: width,
                    height: height,
                    fit: fit,
                    loadStateChanged: loadStateChanged)),
          ),
        ));
  }

  Widget loadStateChanged(ExtendedImageState state) {
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        return Container(
          color: Colors.grey,
        );
      case LoadState.completed:
        return null;
      case LoadState.failed:
        state.imageProvider.evict();
        return GestureDetector(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                "assets/failed.jpg",
                fit: BoxFit.fill,
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Text(
                  "图片加载失败,点击重试",
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          onTap: () {
            state.reLoadImage();
          },
        );
    }
    return null;
  }
}