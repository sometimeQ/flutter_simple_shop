import 'package:demo1/fluro/NavigatorUtil.dart';
import 'package:demo1/provider/user_provider.dart';
import 'package:demo1/util/image_util.dart';
import 'package:demo1/widgets/coupon_price.dart';
import 'package:demo1/widgets/extended_image.dart';
import 'package:demo1/widgets/title_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fsuper/fsuper.dart';
import '../../modals/favorites_model.dart';

// 收藏商品列表卡片布局
class FavoriteGoodsItem extends StatelessWidget {
  Good good;
  bool isShowEditIcon; //是否显示选中按钮
  List<String> selectListIds;
  UserProvider userProvider;
  FavoriteGoodsItem({@required this.good, this.isShowEditIcon,this.selectListIds,this.userProvider});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        height: ScreenUtil().setHeight(500),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Row(
          children: <Widget>[
            ExtendedImageWidget(
              src: MImageUtils.magesProcessor(good.mainPic),
              height: 460,
              width: 460,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  NavigatorUtil.gotoGoodsDetailPage(
                      context, good.id.toString());
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: <Widget>[
                            TitleWidget(
                                title: good.dtitle,
                                color: Colors.black,
                                padding: EdgeInsets.zero),
                            SizedBox(height: 5.0),
                            CouponPriceWidget(
                              actualPrice: good.actualPrice,
                              originalPrice: good.originalPrice,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: _calcDateHowLong(),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      isShowEditIcon ? Positioned(
        right: 10,
        top: 10,
        child: Container(
          width: ScreenUtil().setWidth(200),
          height: ScreenUtil().setHeight(500),
          decoration: BoxDecoration(
//              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Checkbox(
            value: isSelectValue(),
            onChanged: (value){
              if(value){
                userProvider.addRemoveFavoriteGoodsId(good.id.toString());
              }else{
                userProvider.removeFavoriteGoodsId(good.id.toString());
              }
            },
          ),
        ),
      ):Container()
    ]);
  }

  //计算是否在将在删除列表中
  bool isSelectValue(){
    // 如果不存在则返回-1
    var index = selectListIds.indexOf(good.id.toString());
    if(index==-1){
      return false;
    }
    return true;
  }

  // 建立有效期组件
  Widget _calcDateHowLong() {
    DateTime now = DateTime.now();
    DateTime endTime = good.couponEndTime;

    var difference = endTime.difference(now);
    Widget returnWidget = FSuper(
      text: "剩余有效期${difference.inDays}天${difference.inHours % 24}小时",
      textColor: Color(0xffFF7043),
      padding: EdgeInsets.all(2),
      corner: Corner.all(3),
      strokeColor: Color(0xffFF7043),
      strokeWidth: 1,
    );
    if (difference.inDays < 0) {
      returnWidget = FSuper(
        text: "已失效",
        textColor: Color(0xffc2bfc2),
        padding: EdgeInsets.all(2),
        corner: Corner.all(3),
        strokeColor: Color(0xffc2bfc2),
        strokeWidth: 1,
      );
    }

    return returnWidget;
  }
}
