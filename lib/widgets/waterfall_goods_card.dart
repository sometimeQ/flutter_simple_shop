import 'package:extended_image/extended_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as Sc;
import 'package:fsuper/fsuper.dart';
import '../fluro/NavigatorUtil.dart';
import '../util/image_util.dart';

// 小部件
import '../widgets/coupon_price.dart';
import 'extended_image.dart'; // 原价和券后价小部件

// 瀑布流商品卡片
class WaterfallGoodsCard extends StatelessWidget {
  final dynamic datum;

  WaterfallGoodsCard(this.datum);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          NavigatorUtil.gotoGoodsDetailPage(context, datum.id.toString());
        },
        child: Container(
            //width: Sc.ScreenUtil().setWidth(640), // (1440-150) / 2
            padding: EdgeInsets.only(bottom: Sc.ScreenUtil().setHeight(50)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              children: <Widget>[

                _image(),

                SizedBox(height: Sc.ScreenUtil().setHeight(20)),

                // 标题
                _title(datum.dtitle),

                SizedBox(height: Sc.ScreenUtil().setHeight(20)),
                // 购买理由
                Container(
                  padding: EdgeInsets.symmetric(horizontal:  Sc.ScreenUtil().setWidth(40)),
                  child: Text(
                    datum.desc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: Sc.ScreenUtil().setSp(45)
                    ),
                  ),
                ),

                SizedBox(height: Sc.ScreenUtil().setHeight(20)),

                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal:  Sc.ScreenUtil().setWidth(40)),
                  child: FSuper(
                    text: '领 ${NumUtil.getNumByValueDouble(datum.couponPrice,0)} 元券',
                    textSize: Sc.ScreenUtil().setSp(45),
                    padding: EdgeInsets.symmetric(horizontal: Sc.ScreenUtil().setWidth(40)),
                    textColor: Colors.pink,
                    corner: Corner.all(16),
                    strokeColor: Colors.pink,
                    strokeWidth: 0.3,
                  ),
                ),

                SizedBox(height: Sc.ScreenUtil().setHeight(20)),

                Container(
                  padding: EdgeInsets.symmetric(horizontal:  Sc.ScreenUtil().setWidth(40)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      CouponPriceWidget(
                          actualPrice: datum.actualPrice.toString(),
                          originalPrice: datum.originalPrice),
                    ],
                  ),
                ),
//                _hot(datum.twoHoursSales),
                // 图标或者标签显示
//                Container(
//                  margin: EdgeInsets.only(top: 5.0),
//                  child: Row(
//                    children: <Widget>[
//                      _tag("可领${datum.couponPrice}元优惠券", Colors.pinkAccent),
//                      _iconByActivityType(datum.activityType),
//                    ],
//                  ),
//                )
              ],
            )));
  }

  // 两小时销量
  Widget _hot(int twoHoursSales) {
    return Container(
      margin: EdgeInsets.only(top: 2.0, left: 5.0),
      child: Row(
        children: <Widget>[
          Image.asset(
            "assets/icons/hot.png",
            height: Sc.ScreenUtil().setHeight(40),
            width: Sc.ScreenUtil().setWidth(40),
          ),
          Container(
            child: Text(
              "两小时销量${twoHoursSales},月销${datum.monthSales}",
              style: TextStyle(
                  fontSize: Sc.ScreenUtil().setSp(35),
                  color: Colors.pinkAccent),
            ),
          )
        ],
      ),
    );
  }

  Future<Rect> _getImageWH() async {
    Rect rect2 = await WidgetUtil.getImageWH(
        url: MImageUtils.magesProcessor(datum.mainPic));
    return rect2;
  }

  // 标题
  Widget _title(String dtitle) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal:  Sc.ScreenUtil().setWidth(40)),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                dtitle,
                style: TextStyle(
                  color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: Sc.ScreenUtil().setSp(45)
                ),
//                maxLines: 1,
//                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            )
          ],
        ));
  }

  // 商品卡片主图
  Widget _image() {
    String img = datum.mainPic;
    return ExtendedImageWidget(
      src: img,
      height: 645,
      width: 645,
      knowSize: false,
      radius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
    );
  }

  // 标签通用
  Widget _tag(String text, Color bgColor) {
    return Container(
      margin: EdgeInsets.only(left: 5.0),
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.all(Radius.circular(2.0))),
      child: Text(
        text,
        style:
            TextStyle(fontSize: Sc.ScreenUtil().setSp(40), color: Colors.white),
      ),
    );
  }

  // 活动类型，1-无活动，2-淘抢购，3-聚划算
  Widget _iconByActivityType(int activityType) {
    Widget icon = Text(""); // 默认无活动

    if (activityType == 3) {
      icon = Image.asset("assets/icons/jhs.png",
          height: Sc.ScreenUtil().setHeight(60),
          width: Sc.ScreenUtil().setWidth(60));
    }
    if (activityType == 2) {
      icon = Image.asset("assets/icons/qg.png",
          height: Sc.ScreenUtil().setHeight(60),
          width: Sc.ScreenUtil().setWidth(60));
    }
    return Container(margin: EdgeInsets.only(left: 5.0), child: icon);
  }

  // 是否12小时内上架 (1 - 是 ,0 不是)
  Widget _isNewGoods(int newRankingGoods) {
    return newRankingGoods == 1
        ? Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Image.asset("assets/icons/new.png",
                height: Sc.ScreenUtil().setHeight(60),
                width: Sc.ScreenUtil().setWidth(60)),
          )
        : Text("");
  }
}
