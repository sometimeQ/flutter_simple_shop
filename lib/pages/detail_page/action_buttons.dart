import 'package:demo1/constant/color.dart';
import 'package:demo1/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fsuper/fsuper.dart';
import '../../provider/goods_detail_provider.dart';

// 底部浮动操作按钮
class ActionButtons extends StatelessWidget {
  String goodsId;
  final getCallBack;
  GoodsDetailProvider goodsDetailProvider;
  UserProvider userProvider;

  ActionButtons(
      {this.goodsId,
      this.getCallBack,
      this.goodsDetailProvider,
      this.userProvider});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ScreenUtil().setHeight(50),
      left: ScreenUtil().setWidth(70),
      child: FSuper(
        width: ScreenUtil().setWidth(1300),
        height: ScreenUtil().setHeight(240),
        corner: Corner.all(12),
        cornerStyle: CornerStyle.round,
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.85),
        shadowColor: Colors.black26,
        shadowBlur: 10,
        child2: Row(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(600),
              height: ScreenUtil().setHeight(200),
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20),vertical: ScreenUtil().setHeight(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FSuper(
                    height: ScreenUtil().setHeight(250),
//                    width: ScreenUtil().setWidth(180),
                    text: "首页",
                    textSize: ScreenUtil().setSp(40),
                    textAlignment: Alignment.bottomCenter,
                    child1Alignment: Alignment.topCenter,
                    child1: Icon(
                      Icons.home,
                      size: ScreenUtil().setSp(70),
                    ),
                  ),
                  FSuper(
                    height: ScreenUtil().setHeight(250),
//                    width: ScreenUtil().setWidth(180),
                    text: "分享",
                    textSize: ScreenUtil().setSp(40),
                    textAlignment: Alignment.bottomCenter,
                    child1Alignment: Alignment.topCenter,
                    child1: Icon(
                      Icons.share,
                      size: ScreenUtil().setSp(70),
                    ),
                  ),
                  goodsDetailProvider.isHaveFav == 0
                      ? InkWell(
                          onTap: () async {
                            // 添加收藏
                            await goodsDetailProvider.addGoodsFavoriteFun();
                            // 刷新收藏列表
                            await userProvider.resetFavoriteData();
                            await userProvider.loadUserFavoriteGoodsListFun(1);
                          },
                          child: FSuper(
                            height: ScreenUtil().setHeight(250),
//                    width: ScreenUtil().setWidth(180),
                            text: "收藏",
                            textSize: ScreenUtil().setSp(40),
                            textAlignment: Alignment.bottomCenter,
                            child1Alignment: Alignment.topCenter,
                            child1: Icon(
                              Icons.favorite_border,
                              size: ScreenUtil().setSp(70),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            await goodsDetailProvider.removeGoodsFavoriteFun();
                            await userProvider.resetFavoriteData();
                            await userProvider.loadUserFavoriteGoodsListFun(1);
                          },
                          child: FSuper(
                            height: ScreenUtil().setHeight(250),
//                    width: ScreenUtil().setWidth(180),
                            text: "收藏",
                            textColor: primaryColor,
                            textSize: ScreenUtil().setSp(40),
                            textAlignment: Alignment.bottomCenter,
                            child1Alignment: Alignment.topCenter,
                            child1: Icon(
                              Icons.favorite,
                              size: ScreenUtil().setSp(70),
                              color: primaryColor,
                            ),
                          ),
                        )
                ],
              ),
            ),
            FSuper(
              width: ScreenUtil().setWidth(620),
              height: ScreenUtil().setHeight(250),
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              textColor: Color(0xff333333),
              corner: Corner.all(23),
              gradient: LinearGradient(colors: [
                Color(0xfff093fb),
                Color(0xfff5576c),
              ]),
              child2: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Text(
                      "复制口令",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                      height: ScreenUtil().setHeight(40),
                      child: VerticalDivider(color: Colors.white)),
                  InkWell(
                    onTap: getCallBack,
                    child: Container(
                      child: Text(
                        "领券购买",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildVersion1() {
    return Container(
      height: ScreenUtil().setHeight(250),
      width: ScreenUtil().setWidth(1400),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          color: Colors.black12,
          border: Border(top: BorderSide(color: Colors.black12))),
      child: Row(
        children: <Widget>[
          Container(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.share),
            ),
          ),
          Expanded(
            child: goodsDetailProvider.isHaveFav == 0
                ? InkWell(
                    onTap: () async {
                      // 添加收藏
                      await goodsDetailProvider.addGoodsFavoriteFun();
                      // 刷新收藏列表
                      await userProvider.resetFavoriteData();
                      await userProvider.loadUserFavoriteGoodsListFun(1);
                    },
                    child: Container(
                      margin: EdgeInsets.all(12.0),
                      color: Colors.black12,
                      child: Center(
                        child:
                            Text("收藏", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      await goodsDetailProvider.removeGoodsFavoriteFun();
                      await userProvider.resetFavoriteData();
                      await userProvider.loadUserFavoriteGoodsListFun(1);
                    },
                    child: Container(
                      margin: EdgeInsets.all(12.0),
                      color: Colors.black12,
                      child: Center(
                        child:
                            Text("取消收藏", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
          ),
          Expanded(
            child: InkWell(
              onTap: getCallBack,
              child: Container(
                margin: EdgeInsets.all(12.0),
                color: Colors.pinkAccent,
                child: Center(
                  child: Text("领券购买", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
