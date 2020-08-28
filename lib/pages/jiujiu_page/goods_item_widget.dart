import 'package:demo1/util/image_util.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../modals/NineGoodsData.dart';
import '../../widgets/tag_widget.dart';
import '../../fluro/NavigatorUtil.dart';

// 9.9商品卡片布局
class GoodsItemWidget extends StatelessWidget {
  NineGoodsItem goodsItem;

  GoodsItemWidget({@required this.goodsItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom:10.0),
      color: Colors.white,
      width: ScreenUtil().setWidth(1440),
      height: ScreenUtil().setHeight(550),
      child: Row(
        children: <Widget>[
          // 商品图片
          ExtendedImage.network(
            MImageUtils.magesProcessor(goodsItem.mainPic),
            fit: BoxFit.cover,
            width: ScreenUtil().setWidth(500),
            cache: true,
            height: ScreenUtil().setHeight(500),
          ),
//          Container(
//            height: 500,
//            padding: EdgeInsets.all(10.0),
//            child: CacheNetWorkImgWidget(
//              src: goodsItem.mainPic,
//              w: 450,
//              h: 450,
//            )
//          ),
          Expanded(
            child: InkWell(
              onTap: (){
                NavigatorUtil.gotoGoodsDetailPage(context, goodsItem.id.toString());
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //上面部分
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //标题
                            Text(goodsItem.dtitle,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1),
                            //店铺
                            Row(
                              children: <Widget>[
                                TagWidget(title: goodsItem.shopName,noBorder: true),
                              ],
                            ),

                            //券后价
                            Container(
                              margin: EdgeInsets.only(top: 8.0),
                              child: RichText(
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "￥",
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: ScreenUtil().setSp(40))),
                                  TextSpan(
                                      text: "${goodsItem.actualPrice}",
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: ScreenUtil().setSp(70),
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(
                                      text: "  券后价    ",
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: ScreenUtil().setSp(40))),
                                  TextSpan(
                                      text: "原价${goodsItem.originalPrice}",
                                      style: TextStyle(
                                          color: Colors.black38,
                                          decoration: TextDecoration.lineThrough,
                                          fontSize: ScreenUtil().setSp(40))),
                                ]),
                              ),
                            )
                          ],
                        ),
                      ),
                      //下面部分
                      Container(
                        width: ScreenUtil().setWidth(900),
                        height: ScreenUtil().setHeight(120),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 238, 230, 1.0),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(100.0),
                                      bottomRight: Radius.circular(100.0))),
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: "已售",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(45),
                                        color: Color.fromRGBO(137, 60, 17, 1.0)),
                                  ),
                                  TextSpan(
                                    text: " ${goodsItem.monthSales} ",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(65),
                                        color: Color.fromRGBO(255, 91, 0, 1.0)),
                                  ),
                                  TextSpan(
                                    text: "件",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(45),
                                        color: Color.fromRGBO(137, 60, 17, 1.0)),
                                  )
                                ]),
                              ),
                            ),
                            Positioned(
                              right: -3.3,
                              top: 0,
                              child: Image.asset(
                                "assets/images/lijigoumai.png",
                                width: ScreenUtil().setWidth(350),
                                height: ScreenUtil().setHeight(140),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: ScreenUtil().setWidth(280),
                                  height: ScreenUtil().setHeight(120),
                                  child: Text(
                                    "立即购买",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(40),
                                        color: Colors.white),
                                  ),
                                )
                            )
                          ],
                        ),
                      )
                    ]),
              ),
            )
          )
        ],
      ),
    );
  }
}
