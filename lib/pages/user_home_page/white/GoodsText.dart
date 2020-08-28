import 'dart:convert';

import 'package:demo1/modals/GoodsInfo.dart';
import 'package:extended_image/extended_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fsuper/fsuper.dart';


// 商品特殊组件显示

class GoodsText extends SpecialText{
  static final String flag = "[goodsId=";
  final int start;
  final SpecialTextGestureTapCallback onTap;
  GoodsText(TextStyle textStyle,{this.start,this.onTap}) : super(flag, "End]", textStyle);



  @override
  InlineSpan finishText() {

    String goodsText = getContent();
    String jsonStr = goodsText.substring(0,goodsText.lastIndexOf("End"));
    GoodsInfo goodsInfo = GoodsInfo.fromJson(json.decode(jsonStr));
    String dtitle = goodsInfo.data.dtitle;
    String mainPic = goodsInfo.data.mainPic;
    String actualPrice = goodsInfo.data.actualPrice.toString();//券后价
    String discounts = goodsInfo.data.discounts.toString();// 折扣力度
    return ExtendedWidgetSpan(
        actualText: toString(),
        deleteAll: true,
        start: start,
        child: GestureDetector(
          onTap: (){
            print("商品卡片被按下了");
            onTap?.call(jsonStr);
          },
          child: Container(
            height: ScreenUtil().setHeight(400),
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50),vertical: ScreenUtil().setHeight(50)),
            margin: EdgeInsets.only(top: 10,bottom: 10),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              children: <Widget>[
                ExtendedImage.network(
                  mainPic,
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(300),
                  fit: BoxFit.fill,
                  cache: true,
                  border: Border.all(color: Colors.pinkAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),

                  //cancelToken: cancellationToken,
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${dtitle}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis
                          ,style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                            fontSize: ScreenUtil().setSp(60)
                      )),
                      FSuper(
                        padding: EdgeInsets.fromLTRB(9, 6, 9, 6),
                        text: '¥',
                        textSize: 11,
                        textColor: Colors.white,
                        spans: [
                          TextSpan(
                            text: '${actualPrice}券后 ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          TextSpan(
                            text: '${discounts}折',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                        backgroundColor: Colors.pinkAccent,
                        corner: Corner.all(20),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

}