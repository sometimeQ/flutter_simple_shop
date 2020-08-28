import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:demo1/fluro/NavigatorUtil.dart';
import 'package:demo1/modals/Result.dart';
import 'package:demo1/pages/detail_page/hdk/model/index_grid_apecial_data_model.dart';
import 'package:demo1/util/public.dart';
import 'package:demo1/util/request_service.dart';
import 'package:demo1/util/result_obj_util.dart';
import 'package:demo1/util/system_toast.dart';
import 'package:demo1/widgets/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fsuper/fsuper.dart';

import '../index_layout.dart';

class HodgepodgeWidget extends StatefulWidget {
  @override
  _HodgepodgeWidgetState createState() => _HodgepodgeWidgetState();
}

class _HodgepodgeWidgetState extends State<HodgepodgeWidget> {
  double _warpHei = 1340; //容器高度
  double _warpWid = 1340; // 容器宽度

  dynamic futureRequest;
  IndexGridSpecialDataModel dataModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureRequest = initData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureRequest,
      builder: (context, snap) {
        if (snap.hasData) {
          return buildBody();
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  IndexPublicLayout buildBody() {
    return IndexPublicLayout(
      padding: EdgeInsets.zero,
      child: Container(
        height: ScreenUtil().setHeight(_warpHei+2),
        width: ScreenUtil().setWidth(_warpWid),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: <Widget>[
            // 第一行
            Container(
              height: ScreenUtil().setHeight(_warpHei / 2 + 2),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 2.h,color: Colors.grey[200]))
              ),
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // 上左一
                      Container(
                        width: ScreenUtil().setWidth(_warpWid / 2),

                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(30),
                            vertical: ScreenUtil().setHeight(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: buildTitleText(dataModel.leftTopOne.title,
                                  tag: dataModel.leftTopOne.tag,
                              tagTextColor: dataModel.leftTopOne.tagtextColor),
                              height: ScreenUtil().setHeight(150),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(20),
                            ),
                            Container(
                              height: ScreenUtil()
                                  .setHeight(_warpHei / 2 - 30 - 150 - 30 - 20),
                              child: Row(
                                children: <Widget>[
                                  // 迷你卡片
                                  Container(
                                    width: ScreenUtil().setWidth(
                                        (_warpWid / 2 - 30 - 30 - 30) / 2),
                                    height: ScreenUtil().setHeight(
                                        (_warpHei / 2 - 30 - 150 - 30 - 20)),
                                    decoration: BoxDecoration(),
                                    child: InkWell(
                                      onTap: (){
                                        NavigatorUtil.gotoHaodankuGoodsDetailPage(context, dataModel.leftTopOne.goods[0].itemid);
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          buildExtendedImageWidget(
                                              dataModel.leftTopOne.goods[0].itempic),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(10),
                                          ),
                                          Container(
                                              height: ScreenUtil().setHeight(50),
                                              child: buildTextPrice(dataModel
                                                  .leftTopOne.goods[0].itemendprice))
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(30),
                                  ),
                                  //第一行第二个商品
                                  Container(
                                    width: ScreenUtil().setWidth(
                                        (_warpWid / 2 - 30 - 30 - 30) / 2),
                                    height: ScreenUtil().setHeight(
                                        (_warpHei / 2 - 30 - 150 - 30 - 20)),
                                    decoration: BoxDecoration(),
                                    child: InkWell(
                                      onTap: (){
                                        NavigatorUtil.gotoHaodankuGoodsDetailPage(context, dataModel.leftTopOne.goods[1].itemid);
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          buildExtendedImageWidget(
                                              dataModel.leftTopOne.goods[1].itempic),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(10),
                                          ),
                                          Container(
                                              height: ScreenUtil().setHeight(50),
                                              child: buildTextPrice(dataModel
                                                  .leftTopOne.goods[1].itemendprice))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      // 上右二
                      Container(
                        width: ScreenUtil().setWidth(_warpWid / 2 ),
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(30),
                            vertical: ScreenUtil().setHeight(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: buildTitleText(dataModel.rightTopOne.title,
                                  tag: dataModel.rightTopOne.tag,
                              tagTextColor: dataModel.rightTopOne.tagtextColor),
                              height: ScreenUtil().setHeight(150),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(20),
                            ),
                            Container(
                              height: ScreenUtil()
                                  .setHeight(_warpHei / 2 - 30 - 150 - 30 - 20),
                              child: Row(
                                children: <Widget>[
                                  // 迷你卡片
                                  Container(
                                    width: ScreenUtil().setWidth(
                                        (_warpWid / 2 - 30 - 30 - 30) / 2),
                                    height: ScreenUtil().setHeight(
                                        (_warpHei / 2 - 30 - 150 - 30 - 20)),
                                    decoration: BoxDecoration(),
                                    child: InkWell(
                                      onTap: (){
                                        NavigatorUtil.gotoHaodankuGoodsDetailPage(context, dataModel.rightTopOne.goods[0].itemid);
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          buildExtendedImageWidget(
                                              dataModel.rightTopOne.goods[0].itempic),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(10),
                                          ),
                                          Container(
                                              height: ScreenUtil().setHeight(50),
                                              child: buildTextPrice(dataModel
                                                  .rightTopOne.goods[0].itemendprice))
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(30),
                                  ),
                                  Container(
                                    width: ScreenUtil().setWidth(
                                        (_warpWid / 2 - 30 - 30 - 30) / 2),
                                    height: ScreenUtil().setHeight(
                                        (_warpHei / 2 - 30 - 150 - 30 - 20)),
                                    decoration: BoxDecoration(),
                                    child: InkWell(
                                      onTap: (){
                                        NavigatorUtil.gotoHaodankuGoodsDetailPage(context, dataModel.rightTopOne.goods[1].itemid);
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          buildExtendedImageWidget(
                                              dataModel.rightTopOne.goods[1].itempic),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(10),
                                          ),
                                          Container(
                                              height: ScreenUtil().setHeight(80),
                                              child: buildTextPrice(dataModel
                                                  .rightTopOne.goods[1].itemendprice))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(child: Container(color: Colors.grey[300],width: 2.w,height: _warpHei/2,),left: (_warpWid/2).w,)
                ],
              ),
            ),
            // 第二行
            Container(
              height: ScreenUtil().setHeight(_warpHei / 2),
              width: ScreenUtil().setWidth(_warpWid),
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(30),
                  vertical: ScreenUtil().setHeight(30)),
              child: Row(
                children: <Widget>[
                  Container(
                    width: ScreenUtil()
                        .setWidth((_warpWid - 30 - 30 - 30 - 30 - 30) / 4),
                    height: ScreenUtil().setHeight(_warpHei / 2 - 30 - 30),
                    child: Column(
                      children: <Widget>[
                        buildBottomContainer(
                            dataModel.bottomOne.title, dataModel.bottomOne.tag,tagTextColor: dataModel.bottomOne.tagtextColor),
                        InkWell(
                          onTap: (){
                            NavigatorUtil.gotoHaodankuGoodsDetailPage(context, dataModel.bottomOne.goods[0].itemid);
                          },
                          child: ExtendedImageWidget(
                            src: dataModel.bottomOne.goods[0].itempic,
                            width: (_warpWid - 30 - 30 - 30 - 30 - 30) / 4,
                            height: _warpHei / 2 - 30 - 30 - 200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(30),
                  ),
                  Container(
                    width: ScreenUtil()
                        .setWidth((_warpWid - 30 - 30 - 30 - 30 - 30) / 4),
                    height: ScreenUtil().setHeight(_warpHei / 2 - 30 - 30),
                    child: Column(
                      children: <Widget>[
                        buildBottomContainer(
                            dataModel.bottomTwo.title, dataModel.bottomTwo.tag,tagTextColor: dataModel.bottomTwo.tagtextColor),
                        InkWell(
                          onTap: (){
                            NavigatorUtil.gotoHaodankuGoodsDetailPage(context, dataModel.bottomTwo.goods[0].itemid);
                          },
                          child: ExtendedImageWidget(
                            src: dataModel.bottomTwo.goods[0].itempic,
                            width: (_warpWid - 30 - 30 - 30 - 30 - 30) / 4,
                            height: _warpHei / 2 - 30 - 30 - 200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(30),
                  ),
                  Container(
                    width: ScreenUtil()
                        .setWidth((_warpWid - 30 - 30 - 30 - 30 - 30) / 4),
                    height: ScreenUtil().setHeight(_warpHei / 2 - 30 - 30),
                    child: Column(
                      children: <Widget>[
                        buildBottomContainer(dataModel.bottomThree.title,
                            dataModel.bottomThree.tag,tagTextColor: dataModel.bottomThree.tagtextColor),
                        InkWell(
                          onTap: (){
                            NavigatorUtil.gotoHaodankuGoodsDetailPage(context, dataModel.bottomThree.goods[0].itemid);
                          },
                          child: ExtendedImageWidget(
                            src: dataModel.bottomThree.goods[0].itempic,
                            width: (_warpWid - 30 - 30 - 30 - 30 - 30) / 4,
                            height: _warpHei / 2 - 30 - 30 - 200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(30),
                  ),
                  Container(
                    width: ScreenUtil()
                        .setWidth((_warpWid - 30 - 30 - 30 - 30 - 30) / 4),
                    height: ScreenUtil().setHeight(_warpHei / 2 - 30 - 30),
                    child: Column(
                      children: <Widget>[
                        buildBottomContainer(dataModel.bottomFour.title,
                            dataModel.bottomFour.tag,tagTextColor: dataModel.bottomFour.tagtextColor),
                        InkWell(
                          onTap: (){
                            NavigatorUtil.gotoHaodankuGoodsDetailPage(context, dataModel.bottomFour.goods[0].itemid);
                          },
                          child: ExtendedImageWidget(
                            src: dataModel.bottomFour.goods[0].itempic,
                            width: (_warpWid - 30 - 30 - 30 - 30 - 30) / 4,
                            height: _warpHei / 2 - 30 - 30 - 200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextPrice(String price) {
    Widget priceText = FSuper(
      spans: [
        TextSpan(
          text: "¥ ",
          style: TextStyle(fontSize: ScreenUtil().setSp(40), color: Colors.red)
        ),
        TextSpan(
          text: "${price}",
          style: TextStyle(fontSize: ScreenUtil().setSp(50), color: Colors.red)
        )
      ],
    );
    return priceText;
  }


  // 第二行tag迷你标题
  Container buildBottomContainer(String title, String tag,{String tagTextColor}) {

    Color tagColor = Colors.grey;
    if(tagTextColor!=null && tagTextColor !=""){
      tagColor = getColor(tagTextColor);
    }
    return Container(
      height: ScreenUtil().setHeight(200),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(110),
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(60),
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(70),
            alignment: Alignment.center,
            child: Text(
              tag,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(45), color: tagColor),
            ),
          )
          ,
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }

  ExtendedImageWidget buildExtendedImageWidget(String src) {
    return ExtendedImageWidget(
      src: src,
      height: (_warpHei / 2 - 30 - 150 - 30 - 20 - 90),
      width: (_warpHei / 2 - 30 - 100 - 30 - 20),
    );
  }

  Widget buildTitleText(String titleText, {String tag,String tagTextColor}) {
    TextStyle titleTextStyle = TextStyle(
        color: Colors.black,
        fontSize: ScreenUtil().setSp(70),
        fontWeight: FontWeight.bold);

    Color tagColor = Colors.grey;
    if(tagTextColor!=null && tagTextColor !=""){
     tagColor = getColor(tagTextColor);
    }
    return FSuper(
      spans: [
        TextSpan(text: titleText + "  ", style: titleTextStyle),
        TextSpan(
            text: tag ?? "",
            style: TextStyle(
              color: tagColor,
              fontSize: ScreenUtil().setSp(35),
            ))
      ],
    );
  }

  Future<String> initData() async {
    await getIndexGridSpecial().then((res) {
      Result result = ResultUtils.format(res);
      if (result.code == 200) {
        String dataStr = result.data.toString();
        try {
          IndexGridSpecialDataModel indexGridSpecialDataModel =
              IndexGridSpecialDataModel.fromJson(json.decode(dataStr));
          setState(() {
            dataModel = indexGridSpecialDataModel;
          });
        } catch (e, stack) {
          print("报错信息:${e},${stack}");
        }
      } else {
        SystemToast.show(result.msg);
      }
    });
    return "success";
  }
}
