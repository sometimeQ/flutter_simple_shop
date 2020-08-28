import 'package:demo1/provider/goods_detail_provider.dart';
import 'package:demo1/widgets/refresh_and_load_more.dart';
import 'package:fbutton/fbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fsuper/fsuper.dart';
import 'package:provider/provider.dart';
import 'package:demo1/provider/user_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'goods_item.dart';
import '../../widgets/no_data.dart';
import '../../util/system_toast.dart';
import '../../constant/style.dart';

class FavoriteIndexHome extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<FavoriteIndexHome> {
  UserProvider userProvider;
  GoodsDetailProvider goodsDetailProvider;
  RefreshController rc = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        return Scaffold(
          backgroundColor: userProvider.goods.length == 0 ? Colors.white : null,
          appBar: AppBar(
            title: Text("收藏"),
            centerTitle: true,
            actions: !userProvider.isEditFavoriteIng
                ? <Widget>[
                    InkWell(
                      onTap: () {
                        // 编辑
                        userProvider.editorIconClickHandleFun(true);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.edit),
                      ),
                    )
                  ]
                : <Widget>[],
          ),
          body: Stack(
            children: <Widget>[
              Container(
                child: RefreshAndLoadMore(
                  controller: rc,
                  loadMoreFun: l,
                  refreshFun: r,
                  children: userProvider.goods.length != 0
                      ? this
                          .userProvider
                          .goods
                          .map((good) => FavoriteGoodsItem(
                              good: good,
                              isShowEditIcon: userProvider.isEditFavoriteIng,
                              selectListIds: userProvider.editFavoriteIds,
                              userProvider: userProvider))
                          .toList()
                      : [
                          Padding(
                            child: NoDataWidget(title: "暂无收藏"),
                            padding: EdgeInsets.only(top: 20),
                          )
                        ],
                ),
              ),
              //------------收藏列表end
              userProvider.isEditFavoriteIng
                  ? Positioned(
                      bottom: ScreenUtil().setHeight(70),
                      left: ScreenUtil().setWidth(70),
                      width: ScreenUtil().setWidth(1300),
                      height: ScreenUtil().setHeight(200),
                      child: Container(
                        margin: EdgeInsets.all(5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.92),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [boxShaow]),
                        child: Row(
                          children: <Widget>[
                            // 全选/取消全选
                            Container(
                              width: ScreenUtil().setWidth(450),
                              child: Row(
                                children: <Widget>[
                                  Checkbox(
                                    value:
                                        userProvider.editFavoriteIds.length ==
                                            userProvider.goods.length,
                                    onChanged: (v) {
                                      userProvider.selectAll(v);
                                    },
                                  ),
                                  Text(userProvider.editFavoriteIds.length ==
                                      userProvider.goods.length?"取消全选":"全选")
                                ],
                              ),
                            ),
                            // 操作
                            Expanded(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FSuper(
                                      text:"已选 ",
                                      textColor: Colors.grey,
                                      spans: [
                                        TextSpan(
                                          text: userProvider.editFavoriteIds.length.toString(),
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(70),
                                            color: Colors.black
                                          )
                                        ),
                                        TextSpan(
                                          text: " 项",
                                            style: TextStyle(
                                                color: Colors.grey
                                            )
                                        )
                                      ],
                                    ),
                                    FButton(
                                      width: ScreenUtil().setWidth(300),
                                      effect: true,
                                      text: "删除",
                                      textColor: Colors.white,
                                      padding: EdgeInsets.zero,
                                      color: Colors.pinkAccent,
                                      onPressed: userProvider
                                                  .editFavoriteIds.length !=
                                              0
                                          ? () {
                                              if (userProvider
                                                      .editFavoriteIds.length !=
                                                  0) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          title: Text('提示'),
                                                          content:
                                                              Text(('确定删除吗')),
                                                          actions: <Widget>[
                                                            new FlatButton(
                                                              child: new Text(
                                                                  "取消"),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                            new FlatButton(
                                                              child: new Text(
                                                                  "确定"),
                                                              onPressed:
                                                                  () async {
                                                                await userProvider
                                                                    .editFavoriteIds
                                                                    .forEach(
                                                                        (id) async {
                                                                  await goodsDetailProvider
                                                                      .removeGoodsFavoriteFun(
                                                                          goodsId:
                                                                              id);
                                                                });
                                                                userProvider
                                                                    .removeFavoriteOk();
                                                                SystemToast
                                                                    .show(
                                                                        "删除成功");
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ],
                                                        ));
                                              }
                                            }
                                          : null,
                                      clickEffect: true,
                                      shadowBlur: 10.0,
                                      corner: FButtonCorner.all(25),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          userProvider
                                              .editorIconClickHandleFun(false);
                                        },
                                        child: Icon(Icons.clear))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        );
      },
    );
  }

  void r() async {
    await this.userProvider.loadUserFavoriteGoodsListFun(1);
    rc.refreshCompleted();
    rc.footerMode.value = LoadStatus.idle;
  }

  void l() async {
    // 判断是不是最后一页
    if (!this.userProvider.pageInfo.last) {
      await this.userProvider.loadNextPageUserFavoriteGoodsListFun();
      rc.loadComplete();
    } else {
      rc.footerMode.value = LoadStatus.noMore;
    }
  }

  @override
  void didChangeDependencies() {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    GoodsDetailProvider goodsDetailProvider =
        Provider.of<GoodsDetailProvider>(context);
    if (this.userProvider != userProvider) {
      this.userProvider = userProvider;
    }
    if (this.goodsDetailProvider != goodsDetailProvider) {
      this.goodsDetailProvider = goodsDetailProvider;
    }
  }
}
