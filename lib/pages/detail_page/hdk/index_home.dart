import 'dart:convert';
import 'dart:ui';

import 'package:demo1/modals/Result.dart';
import 'package:demo1/modals/couponData.dart';
import 'package:demo1/modals/shop_info.dart';
import 'package:demo1/pages/detail_page/hdk/model/hdk_detail.dart';
import 'package:demo1/util/api.dart';
import 'package:demo1/util/image_util.dart';
import 'package:demo1/util/request.dart';
import 'package:demo1/util/request_service.dart';
import 'package:demo1/util/result_obj_util.dart';
import 'package:demo1/util/system_toast.dart';
import 'package:demo1/widgets/RoundUnderlineTabIndicator.dart';
import 'package:demo1/widgets/extended_image.dart';
import 'package:demo1/widgets/my_drawable_start_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fbutton/fbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fsuper/fsuper.dart';
import 'package:luhenchang_plugin/time/data_time_utils/data_time.dart';
import 'package:url_launcher/url_launcher.dart';

class HaoDanKuDetailItem extends StatefulWidget {
  String goods_id;

  HaoDanKuDetailItem({this.goods_id});

  @override
  _HaoDanKuDetailItemState createState() => _HaoDanKuDetailItemState();
}

class _HaoDanKuDetailItemState extends State<HaoDanKuDetailItem>
    with TickerProviderStateMixin {
  List<String> images = []; // 商品详情图
  Info info;
  List<Video> videos = [];
  ShopInfo _shopInfo;
  var futureBuildData;
  double _appbarOpaction = 0;
  int curentSwaiperIndex = 0;
  double ztlHei = MediaQueryData.fromWindow(window).padding.top; // 转态栏高度
  double _topAppbarHei = 0; // 顶部显影工具条的高度
  double _initImagesTopHei = 0; // 图片详情距离顶部的高度 (包含转态栏)
  bool _showToTopButton = false; // 显示返回顶部按钮

  TabController _tabController;
  ScrollController _scrollController;
  final GlobalKey _swaperGlogbalKey = GlobalKey();
  final GlobalKey _appbarGlogbalKey = GlobalKey();
  final GlobalKey _detailImagesGlogbalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureBuildData = initDatas();

    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _scrollController = ScrollController();
  }

  void addScrollListener() {
    _scrollController.addListener(() {
      // 控制顶部导航显影
      double scrollHeight = _scrollController.offset;
      double t = scrollHeight / (MediaQuery.of(context).size.width * 0.85);
      if (scrollHeight == 0) {
        t = 0;
      } else if (t > 1.0) {
        t = 1.0;
      }
      setState(() {
        _appbarOpaction = t;
      });

      /// // 控制顶部导航显影

      //计算详情widget到顶部距离
      double topHei = getY(_detailImagesGlogbalKey.currentContext);
      if (topHei <= _topAppbarHei + ztlHei) {
        _tabController.animateTo(1);
      } else {
        if (_tabController.index != 0) {
          _tabController.animateTo(0);
        }
      }
    });
  }

  // 顶部选项卡被切换
  void tabOnChange(index) {
    print("${index}");
    if (index == 0) {
      _scrollController.animateTo(0,
          duration: Duration(milliseconds: 600), curve: Curves.ease);
    } else if (index == 1) {
      _scrollController.animateTo(
          _initImagesTopHei - ztlHei - _topAppbarHei + 5,
          duration: Duration(milliseconds: 600),
          curve: Curves.ease);
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _scrollController.addListener(() {
      double scrollHeight = _scrollController.offset;
      double t = scrollHeight / (MediaQuery.of(context).size.width * 0.85);
      if (scrollHeight == 0) {
        t = 0;
      } else if (t > 1.0) {
        t = 1.0;
        _showToTopButton = true;
      } else if (scrollHeight < 200) {
        _showToTopButton = false;
      }
      setState(() {
        _appbarOpaction = t;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.grey,
        ///这是设置状态栏的图标和字体的颜色
        ///Brightness.light  一般都是显示为白色
        ///Brightness.dark 一般都是显示为黑色
        statusBarIconBrightness: Brightness.light
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: FutureBuilder(
        future: futureBuildData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return buildCustomScrollViewShop();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildCustomScrollViewShop() {
    return NotificationListener<LayoutChangedNotification>(
      onNotification: (notification) {
        if (_topAppbarHei == 0) {
          setState(() {
            _topAppbarHei = _appbarGlogbalKey.currentContext.size.height +
                MediaQueryData.fromWindow(window).padding.top;
            _initImagesTopHei = getY(_detailImagesGlogbalKey.currentContext);
          });
          addScrollListener();
        }
        return null;
      },
      child: Stack(
        children: <Widget>[
          NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: buildGoodsSwiper(),
                  ),
                  buildSliverToBoxAdapterOne(),
                  buildSliverToBoxAdapterTwo(),
                  buildSliverToBoxAdapterThree(),
                  buildSliverToBoxAdapterFour(),
                  buildSliverToBoxAdapterFive(),
                  buildSliverToBoxAdapterSix(),
                  buildSliverToBoxAdapterPlaceholder(),
                  buildSliverToBoxAdapterShop(),
                  buildSliverToBoxAdapterPlaceholder(),
                ];
              },
              body: buildGoodsDetailImaegs()),
          buildOpacityAppbar(),
          // 返回顶部按钮
          _showToTopButton
              ? Positioned(
                  bottom: ScreenUtil().setHeight(390),
                  right: ScreenUtil().setWidth(70),
                  child: InkWell(
                    onTap: () {
                      _scrollController.animateTo(0,
                          duration: Duration(milliseconds: 600),
                          curve: Curves.ease);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(35)),
                          border: Border.all(
                              width: .5,
                              color: Colors.black26.withOpacity(.2))),
                      child: Icon(
                        Icons.vertical_align_top,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : Container(),

          //底部操作栏
          Positioned(
            bottom: ScreenUtil().setHeight(0),
            left: ScreenUtil().setWidth(0),
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(0)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              width: ScreenUtil().setWidth(1440),
              height: ScreenUtil().setHeight(250),
              child: Row(
                children: <Widget>[
                  Container(
                      height: ScreenUtil().setHeight(150),
                      width: ScreenUtil().setWidth(620),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Center(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.home,
                                  size: ScreenUtil().setSp(50),
                                ),
                                Text(
                                  "首页",
                                  style:
                                      TextStyle(fontSize: ScreenUtil().setSp(40)),
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.share,
                                  size: ScreenUtil().setSp(50),
                                ),
                                Text(
                                  "分享",
                                  style:
                                      TextStyle(fontSize: ScreenUtil().setSp(40)),
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.local_pharmacy,
                                  size: ScreenUtil().setSp(50),
                                ),
                                Text(
                                  "收藏",
                                  style:
                                      TextStyle(fontSize: ScreenUtil().setSp(40)),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                  Container(
                    width: ScreenUtil().setWidth(820),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FSuper(
                          height: ScreenUtil().setHeight(150),
                          width: ScreenUtil().setWidth(335),
                          text: '复制口令',
                          textWeight: FontWeight.bold,
                          textAlignment: Alignment.center,
                          textSize: ScreenUtil().setSp(45),
                          textColor: Colors.white,
                          corner: Corner.all(23),
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(50)),
                          gradient: LinearGradient(colors: [
                            Colors.redAccent,
                            Color(0xfffcad2c),
                          ]),
                          onClick: () async {
                            await getPrivilegeLink({"goodsId": info.itemid})
                                .then((res) async {
                              Result resultObj = ResultUtils.format(res);
                              if (resultObj.code == 200) {
                                CouponInfo couponInfo = CouponInfo.fromJson(
                                    json.decode(resultObj.data.toString()));
                                if (couponInfo.code == 0) {
                                  String tkl =
                                      couponInfo.data.tpwd;
                                  Clipboard.setData(ClipboardData(text: tkl));
                                  SystemToast.show("复制成功,打开手淘即可领取");
                                }
                              } else {
                                print("复制失败:${resultObj.msg}");
                              }
                            });
                          },
                        ),
                        FSuper(
                          height: ScreenUtil().setHeight(150),
                          width: ScreenUtil().setWidth(335),
                          text: '立即领券',
                          textWeight: FontWeight.bold,
                          textAlignment: Alignment.center,
                          textSize: ScreenUtil().setSp(45),
                          textColor: Colors.white,
                          corner: Corner.all(23),
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(50)),
                          gradient: LinearGradient(colors: [
                            Colors.pinkAccent,
                            Color(0xfffcad2c),
                          ]),
                          onClick: () async {
                            await getPrivilegeLink({"goodsId": info.itemid})
                                .then((res) async {
                              Result resultObj = ResultUtils.format(res);
                              if (resultObj.code == 200) {
                                CouponInfo couponInfo = CouponInfo.fromJson(
                                    json.decode(resultObj.data.toString()));
                                if (couponInfo.code == 0) {
                                  String couponClickUrl =
                                      couponInfo.data.couponClickUrl;
                                  String url =
                                      "taobao://${couponClickUrl.substring(8)}";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    launch(couponInfo.data.couponClickUrl);
                                  }
                                }
                              } else {
                                print("领取失败:${resultObj.msg}");
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // 详情图
  Widget buildGoodsDetailImaegs() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              "宝贝详情",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(50),
                horizontal: ScreenUtil().setWidth(50)),
            alignment: Alignment.topLeft,
          ),
          buildImagesWidget()
        ],
      ),
    );
  }

  // 店铺信息
  Widget buildSliverToBoxAdapterShop({isSliver = true}) {
    Widget widget = ContainerWarp(Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(670),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage:
                      _shopInfo != null && _shopInfo.pictUrl != null
                          ? NetworkImage(
                              MImageUtils.magesProcessor(_shopInfo.pictUrl))
                          : AssetImage("assets/images/ava.png"),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(30),
                ),
                Text(
                  _shopInfo != null ? _shopInfo.sellerNick : "店铺名初始化",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(670),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FButton(
                  effect: true,
                  text: "进店逛逛",
                  textColor: Color.fromRGBO(254, 55, 56, 1),
                  color: Colors.white,
                  padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                  onPressed: () {},
                  clickEffect: true,
                  strokeColor: Color.fromRGBO(254, 55, 56, 1),
                  strokeWidth: 1,
                  corner: FButtonCorner.all(25),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(20),
                ),
                FButton(
                  effect: true,
                  text: "全部商品",
                  textColor: Colors.white,
                  color: Color.fromRGBO(254, 55, 56, 1),
                  padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                  onPressed: () {},
                  clickEffect: true,
                  strokeWidth: 1,
                  corner: FButtonCorner.all(25),
                ),
              ],
            ),
          )
        ],
      ),
    ));
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(
      child: _shopInfo != null ? widget : Container(),
    );
  }

  // 轮播图阴影
  Positioned buildPositionedYy() {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        height: ScreenUtil().setHeight(400),
        width: ScreenUtil().setWidth(1440),
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
          Colors.grey[700].withOpacity(.2),
          Colors.grey.withOpacity(.0),
        ])),
      ),
    );
  }

  // 占位
  Widget buildSliverToBoxAdapterPlaceholder({isSliver = true}) {
    Widget widget = Container(
      color: Color.fromRGBO(246, 245, 245, 1.0),
      height: ScreenUtil().setHeight(50),
    );
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(
      child: Container(
        color: Color.fromRGBO(246, 245, 245, 1.0),
        height: ScreenUtil().setHeight(50),
      ),
    );
  }

  // 第六行,推荐语
  Widget buildSliverToBoxAdapterSix({isSliver = true}) {
    Widget widget = ContainerWarp(
        Container(
          alignment: Alignment.topLeft,
          child: FSuper(
            textAlign: TextAlign.start,
            textSize: ScreenUtil().setSp(40),
            spans: [
              TextSpan(
                  text: "推荐理由: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "${info.itemdesc}",
                  style: TextStyle(color: Colors.grey)),
              TextSpan(
                  text: "复制文案",
                  style: TextStyle(color: Colors.pinkAccent),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Clipboard.setData(ClipboardData(text: info.itemdesc));
                      SystemToast.show("复制成功");
                    })
            ],
          ),
        ),
        height: 30);
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(
      child: widget,
    );
  }

  // 第五行,领券
  Widget buildSliverToBoxAdapterFive({isSliver = true}) {
    Widget widget = ContainerWarp(
        InkWell(
          onTap: () async {
            await getPrivilegeLink({"goodsId": info.itemid})
                .then((res) async {
              Result resultObj = ResultUtils.format(res);
              if (resultObj.code == 200) {
                CouponInfo couponInfo = CouponInfo.fromJson(
                    json.decode(resultObj.data.toString()));
                if (couponInfo.code == 0) {
                  String couponClickUrl =
                      couponInfo.data.couponClickUrl;
                  String url =
                      "taobao://${couponClickUrl.substring(8)}";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    launch(couponInfo.data.couponClickUrl);
                  }
                }
              } else {
                print("领取失败:${resultObj.msg}");
              }
            });
          },
          child: Container(
            width: ScreenUtil().setWidth(1440),
            height: ScreenUtil().setHeight(300),
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
                vertical: ScreenUtil().setHeight(20)),
            decoration: BoxDecoration(
                color: Color.fromRGBO(252, 54, 74, 1.0),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(900),
                      height: ScreenUtil().setHeight(260),
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20),
                          vertical: ScreenUtil().setHeight(30)),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 237, 199, 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "${info.couponmoney}元优惠券",
                              style: TextStyle(
                                  color: Color.fromRGBO(145, 77, 9, 1.0),
                                  fontSize: ScreenUtil().setSp(60),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          Container(
                            child: Text(
                              "使用日期:${getTimeStr(info.couponstarttime)} - ${getTimeStr(info.couponendtime)}",
                              style: TextStyle(
                                  color: Color.fromRGBO(145, 77, 9, 1.0),
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                    // 圆
                    Positioned(
                      left: ScreenUtil().setWidth(-25),
                      top: ScreenUtil().setHeight(105),
                      child: Container(
                        height: ScreenUtil().setHeight(50),
                        width: ScreenUtil().setWidth(50),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(252, 54, 74, 1.0)),
                      ),
                    ),
                    Positioned(
                      right: ScreenUtil().setWidth(-25),
                      top: ScreenUtil().setHeight(105),
                      child: Container(
                        height: ScreenUtil().setHeight(50),
                        width: ScreenUtil().setWidth(50),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(252, 54, 74, 1.0)),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(50)),
                    child: Text(
                      "立即领券 >",
                      style: TextStyle(
                          color: Colors.white, fontSize: ScreenUtil().setSp(50)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        height: 20);
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(
      child: widget,
    );
  }

  // 第四行,满减
  Widget buildSliverToBoxAdapterFour({isSliver = true}) {
    Widget widget = ContainerWarp(Container(
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(250),
            child: Text(
              "满减",
              style: TextStyle(
                  color: Colors.grey, fontSize: ScreenUtil().setSp(45)),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                FSuper(
                  text: "满减",
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  corner: Corner.all(5),
                  textSize: ScreenUtil().setSp(40),
                  textAlign: TextAlign.center,
                  textAlignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20),
                      vertical: ScreenUtil().setHeight(5)),
                ),
                Text(
                  " ${info.couponexplain == '' ? "活动已过期" : info.couponexplain}",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: ScreenUtil().setSp(45),
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    ));
    if (!isSliver) {
      return isSliver;
    }
    return SliverToBoxAdapter(child: widget);
  }

  // 第三行,标题
  Widget buildSliverToBoxAdapterThree({isSliver = true}) {
    Widget widget = ContainerWarp(
        Container(
          width: ScreenUtil().setWidth(1440),
          child: DrawableStartText(
            lettersCountOfAfterImage: info.itemshorttitle.length,
            assetImage: info.shoptype == "B"
                ? "assets/icons/tianmao2.png"
                : "assets/icons/taobao2.png",
            text: " ${info.itemtitle}",
            textStyle: new TextStyle(
                fontSize: ScreenUtil().setSp(50), fontWeight: FontWeight.w400),
          ),
        ),
        height: 20);
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(
      child: widget,
    );
  }

  // 第二行,原价+销量
  Widget buildSliverToBoxAdapterTwo({isSliver = true}) {
    Widget widget = ContainerWarp(
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FSuper(
                spans: <TextSpan>[
                  TextSpan(
                      text: "原价 ${info.itemprice}",
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough))
                ],
              ),
              FSuper(
                text: "已售 ${info.itemsale}",
                textColor: Colors.grey,
              )
            ],
          ),
        ),
        height: 20);
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(
      child: widget,
    );
  }

  // 第一行,券后价+返佣
  Widget buildSliverToBoxAdapterOne({isSliver = true}) {
    Widget widget = ContainerWarp(
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FSuper(
              text: '券后价 ¥',
              textSize: ScreenUtil().setSp(50),
              textColor: Colors.redAccent,
              spans: [
                TextSpan(
                  text: '${info.itemendprice} ',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: ScreenUtil().setSp(100),
                      fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: '${info.discount}折',
                  style: TextStyle(fontSize: ScreenUtil().setSp(50)),
                ),
              ],
              corner: Corner.all(20),
            ),

            // 预计可得
            FSuper(
              text: "预计收益 ¥${info.tkmoney}",
              textSize: ScreenUtil().setSp(45),
              textColor: Colors.red,
              backgroundColor: Colors.pinkAccent.withOpacity(0.1),
              shadowBlur: 4,
              textWeight: FontWeight.w600,
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                  vertical: ScreenUtil().setHeight(5)),
            ),
          ],
        ),
      ),
      height: 10,
    );
    if (!isSliver) {
      return widget;
    }
    return SliverToBoxAdapter(
      child: widget,
    );
  }

  Widget ContainerWarp(Widget child, {double height: 0}) {
    return Container(
      child: child,
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(50),
          vertical: ScreenUtil().setHeight(height)),
    );
  }

  // 轮播
  Widget buildGoodsSwiper() {
    var swiper = Swiper(
      key: _swaperGlogbalKey,
      autoplay: getImages().isNotEmpty,
      duration: 1000,
      loop: true,
      itemBuilder: (BuildContext context, int index) {
        return ExtendedImageWidget(
          width: 1440,
          height: 1440,
          src: getImages()[index],
          fit: BoxFit.fitWidth,
          knowSize: true,
        );
      },
      onIndexChanged: (index) {
        setState(() {
          curentSwaiperIndex = index;
        });
      },
      itemCount: getImages().length,
    );

    return Stack(
      children: <Widget>[
        buildContainer(swiper: swiper),
        buildPositionedYy(),
        Positioned(
          left: ScreenUtil().setWidth(50),
          top: ScreenUtil().setHeight(50) + ztlHei,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: Colors.black26.withOpacity(.3),
              child: Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          right: ScreenUtil().setWidth(50),
          bottom: ScreenUtil().setHeight(50),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black26.withOpacity(.3),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
                vertical: ScreenUtil().setHeight(20)),
            child: Text(
              "${curentSwaiperIndex + 1} / ${getImages().length}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  // 顶部显影appbar
  Opacity buildOpacityAppbar() {
    return Opacity(
      opacity: _appbarOpaction,
      child: Container(
        key: _appbarGlogbalKey,
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        margin:
            EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
        height: ScreenUtil().setHeight(200),
        decoration: BoxDecoration(
            color: Colors.white, boxShadow: [BoxShadow(color: Colors.black26)]),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: ScreenUtil().setWidth(300),
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: TabBar(
                indicator: RoundUnderlineTabIndicator(
                    insets: EdgeInsets.only(bottom: 3),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.red,
                    )),
                labelColor: Colors.black,
                tabs: [
                  Tab(text: "宝贝"),
                  Tab(text: "详情"),
                  Tab(text: "推荐"),
                ],
                controller: _tabController,
                onTap: tabOnChange,
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(300),
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainer({Widget swiper}) {
    return Container(
      height: ScreenUtil().setHeight(1340),
      margin:
          EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
      child: swiper,
    );
  }

  // 商品详情图
  SingleChildScrollView buildImagesWidget() {
    return SingleChildScrollView(
      key: _detailImagesGlogbalKey,
      child: Column(
          children: images
              .map((item) => ExtendedImage.network(
                    MImageUtils.magesProcessor(item),
                    fit: BoxFit.fill,
                    cache: true,
                  ))
              .toList()),
    );
  }

  String getTimeStr(String timeMs) {
    if (timeMs.isNotEmpty) {
      return DateUtils.instance
          .getFormartDate(int.parse(timeMs), format: "yyyy-MM-dd");
    }
    return "未知";
  }

  List<String> getImages() {
    String str = info.taobaoImage;
    return str.split(",");
  }

  String getCatName(String fqcat) {
    List<String> cats = [
      "女装",
      "男装",
      "内衣",
      "美妆",
      "配饰",
      "鞋品",
      "箱包",
      "儿童",
      "母婴",
      "居家",
      "美食",
      "数码",
      "家电",
      "其他",
      "车品",
      "文体",
      "宠物"
    ];
    return cats[int.parse(fqcat) - 1];
  }

  Future<String> initDatas() async {
    await getHaodankuDetailInfo(widget.goods_id).then((res) {
      Result result = Result.fromJson(json.decode(res.toString()));
      if (result.code == 200) {
        HdkGoodsDetailModel hdkGoodsDetailModel =
            HdkGoodsDetailModel.fromJson(json.decode(result.data));
        setState(() {
          images = hdkGoodsDetailModel.images;
          info = hdkGoodsDetailModel.info;
          videos = hdkGoodsDetailModel.video;
        });
      }else{
        SystemToast.show(result.msg);
      }
    });
    await post(Api.API_GET_SHOP_INFO, data: {"shopName": info.sellernick})
        .then((res) {
      Result result = ResultUtils.format(res);
      if (result.code == 200) {
        ShopInfo shopInfo =
            ShopInfo.fromJson(json.decode(result.data.toString()));
        setState(() {
          _shopInfo = shopInfo;
        });
      } else {
        SystemToast.show(result.msg);
      }
    });

    return "success";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  // 获取widget距离顶部的位置
  double getY(BuildContext buildContext) {
    final RenderBox box = buildContext.findRenderObject();
    //final size = box.size;
    final topLeftPosition = box.localToGlobal(Offset.zero);
    return topLeftPosition.dy;
  }
}
