import 'package:flutter/material.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'AtText.dart';
import 'ImageText.dart';
import 'GoodsText.dart';

class MySpecialTextSpanBuilder extends SpecialTextSpanBuilder {

  final bool showAtBackground;
  final Function goodsCardOnTapCallBack;
  MySpecialTextSpanBuilder(
      {this.showAtBackground: false,this.goodsCardOnTapCallBack});

  @override
  TextSpan build(String data, {TextStyle textStyle, onTap}) {
    var textSpan = super.build(data, textStyle: textStyle, onTap: onTap);
    return textSpan;
  }

  @override
  SpecialText createSpecialText(String flag,
      {TextStyle textStyle, SpecialTextGestureTapCallback onTap, int index}) {
    if (flag == null || flag == "") return null;

    ///index is end index of start flag, so text start index should be index-(flag.length-1)
    if (isStart(flag, AtText.flag)) {
      return AtText(textStyle, onTap,
          start: index - (AtText.flag.length - 1),
          showAtBackground: showAtBackground,
      );
    }else if (isStart(flag, ImageText.flag)) {
      return ImageText(textStyle,
          start: index - (ImageText.flag.length - 1), onTap: onTap);
    }else if(isStart(flag, GoodsText.flag)){
      return GoodsText(textStyle,start: index-(GoodsText.flag.length-1),onTap: goodsCardOnTapCallBack);
    }
    return null;
  }
}