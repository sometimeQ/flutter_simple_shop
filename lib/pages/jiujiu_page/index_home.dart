import 'package:demo1/modals/NineGoodsData.dart';
import 'package:demo1/pages/jiujiu_page/image_nav.dart';
import 'package:demo1/repository/jiujiu_respository.dart';
import 'package:demo1/widgets/RoundUnderlineTabIndicator.dart';
import 'package:demo1/widgets/index_sticky_tabbar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import './header_menu.dart';
import './goods_list_widget.dart';
import '../../provider/nine_goods_provider.dart'; // 9.9包邮的provider
import '../../widgets/pull_to_refresh_widget.dart';
import 'goods_item_widget.dart';
import 'menu_data.dart';

// 9.9包邮专区
class JiujiuIndexHome extends StatefulWidget {
  ScrollController scrollController;

  JiujiuIndexHome({this.scrollController});

  @override
  _JiujiuIndexHomeState createState() => _JiujiuIndexHomeState();
}

class _JiujiuIndexHomeState extends State<JiujiuIndexHome>
    with TickerProviderStateMixin {
  NineGoodsProvider nineGoodsProvider;
  bool initLoading = false;
  bool nextPageLoading = false;

  JiuJiuRepository jiuJiuRepository;
  TabController tabController;

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  //  刷新
  void _onRefresh() async {
    if (this.nineGoodsProvider != null) {
      _setInitLoadingState(true);
      await nineGoodsProvider.loadNineGoodsList("1", "");
      _setInitLoadingState(false);
    }
    _refreshController.refreshCompleted();
  }

//  加载更多
  void _onLoading() async {
    if (nineGoodsProvider != null && !nextPageLoading) {
      _setNextPageLoadingState(true);
      await nineGoodsProvider.loadNextPageData();
      _setNextPageLoadingState(false);
    }

    _refreshController.loadComplete();
  }

  @override
  void initState() {
    this.jiuJiuRepository = JiuJiuRepository("-1");
    this.tabController = TabController(length: menu_text.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NineGoodsProvider>(
      builder: (context, nineGoodsProvider, _) => PullToRefreshNotification(
        pullBackOnRefresh: true,
        maxDragOffset: 80.0,
        onRefresh: () async {
          await jiuJiuRepository.refresh(true);
          return true;
        },
        child: LoadingMoreCustomScrollView(slivers: <Widget>[
          SliverAppBar(
            title: Text("9块9包邮"),
            centerTitle: true,
            pinned: true,
          ),
          // 顶部图片导航
          SliverToBoxAdapter(
            child: buildRow1(),
          ),
          SliverToBoxAdapter(
            child: buildRow2(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: IndexStickyTabBarDelegate(
                color: Colors.white,
                child: TabBar(
                  onTap: (index) async {
                    setState(() {
                      jiuJiuRepository =
                          JiuJiuRepository(menu_ids[index].toString());
                    });
                    await jiuJiuRepository.refresh(true);
                  },
                  controller: tabController,
                  isScrollable: true,
                  indicator: RoundUnderlineTabIndicator(
                      insets: EdgeInsets.only(bottom: 8),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.pinkAccent,
                      )),
                  tabs: menu_text.map((item) {
                    return Tab(text: item);
                  }).toList(),
                  labelColor: Colors.pinkAccent,
                  labelStyle: TextStyle(
                      fontSize: ScreenUtil().setSp(50),
                      fontWeight: FontWeight.w600),
                  indicatorColor: Colors.pinkAccent,
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle:
                      TextStyle(fontSize: ScreenUtil().setSp(50)),
                )),
          ),
          LoadingMoreSliverList(SliverListConfig<NineGoodsItem>(
              itemBuilder: (context, item, index) {
                return GoodsItemWidget(
                  goodsItem: item,
                );
              },
              sourceList: jiuJiuRepository))
          //
        ], rebuildCustomScrollView: true),
      ),
    );
  }

  SmartRefresher buildSmartRefresher_old(NineGoodsProvider nineGoodsProvider) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      enablePullDown: true,
      enablePullUp: true,
      physics: ClampingScrollPhysics(),
      header: BezierCircleHeader(),
      footer: PullToRefreshWidgetFoot(),
      child: ListView(
        controller: widget.scrollController,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          buildRow1(),
          buildRow2(),
          HeaderMenu(onChangeCallBack: this.onChangeCallBack),
          GoodsListWidget(
            list: nineGoodsProvider.goods,
            isInitLoading: initLoading,
          ),
        ],
      ),
    );
  }

  Row buildRow2() {
    return Row(
      children: <Widget>[
        Container(
          child: ImageNav(
            height: 360,
            width: 720,
            src:
                "https://img.alicdn.com/imgextra/i2/2053469401/O1CN019KHY9k2JJi0Bt8k5B_!!2053469401.jpg",
            onTap: () {},
            title: Text(
              "19.9元专区",
              style: TextStyle(color: Color.fromRGBO(253, 87, 92, 1.0)),
            ),
            subTitle: Text(
              "半价抢不停",
              style: TextStyle(color: Color(0xff888888)),
            ),
          ),
        ),
        Container(
          child: ImageNav(
            height: 360,
            width: 360,
            src:
                "https://img.alicdn.com/imgextra/i4/2053469401/O1CN01uyQmiF2JJi15GeiZE_!!2053469401.jpg",
            onTap: () {},
            title: Text(
              "驱蚊止痒",
              style: TextStyle(color: Color(0xff8FBC8F)),
            ),
            subTitle: Text(
              "不怕蚊虫",
              style: TextStyle(color: Color(0xff888888)),
            ),
          ),
        ),
        Container(
          child: ImageNav(
            height: 360,
            width: 360,
            src:
                "https://img.alicdn.com/imgextra/i1/2053469401/O1CN01Wl3zrd2JJi13RVIY6_!!2053469401.jpg",
            onTap: () {},
            title: Text(
              "潮流T恤",
              style: TextStyle(color: Color(0xffDC143C)),
            ),
            subTitle: Text(
              "清凉一夏",
              style: TextStyle(color: Color(0xff888888)),
            ),
          ),
        )
      ],
    );
  }

  Row buildRow1() {
    return Row(
      children: <Widget>[
        Container(
          child: ImageNav(
            height: 360,
            width: 720,
            src:
                "https://img.alicdn.com/imgextra/i1/2053469401/O1CN01DKsIHJ2JJi0Bt78I3_!!2053469401.jpg",
            onTap: () {},
            title: Text(
              "9块9每日精选",
              style: TextStyle(color: Color(0xffFF1493)),
            ),
            subTitle: Text(
              "十元封顶",
              style: TextStyle(color: Color(0xff888888)),
            ),
          ),
        ),
        Container(
          child: ImageNav(
            height: 360,
            width: 360,
            src:
                "https://img.alicdn.com/imgextra/i3/2053469401/O1CN01R48n0q2JJi16huc5i_!!2053469401.jpg",
            onTap: () {},
            title: Text(
              "粽香四溢",
              style: TextStyle(color: Color(0xff4169E1)),
            ),
            subTitle: Text(
              "传统味道",
              style: TextStyle(color: Color(0xff888888)),
            ),
          ),
        ),
        Container(
          child: ImageNav(
            height: 360,
            width: 360,
            src:
                "https://img.alicdn.com/imgextra/i4/2053469401/O1CN017g9IMN2JJi12uMZ1g_!!2053469401.jpg",
            onTap: () {},
            title: Text(
              "美妆必备",
              style: TextStyle(color: Color.fromRGBO(114, 11, 252, 1.0)),
            ),
            subTitle: Text(
              "'妆'出精致",
              style: TextStyle(color: Color(0xff888888)),
            ),
          ),
        )
      ],
    );
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    NineGoodsProvider nineGoodsProvider =
        Provider.of<NineGoodsProvider>(context);
    if (this.nineGoodsProvider != nineGoodsProvider) {
      this.nineGoodsProvider = nineGoodsProvider;
      _setInitLoadingState(true);
      await this.nineGoodsProvider.loadNineGoodsList("1", "-1");
      _setInitLoadingState(false);
    }
  }

  void _setInitLoadingState(bool isLoading) {
    setState(() {
      initLoading = isLoading;
    });
  }

  void _setNextPageLoadingState(bool isLoading) {
    setState(() {
      nextPageLoading = isLoading;
    });
  }

//  选项卡被切换
  void onChangeCallBack(index, cid) async {
    _setInitLoadingState(true);
    await nineGoodsProvider.setCurrentNineCid(cid.toString());
    await nineGoodsProvider.loadNineGoodsList("1", cid.toString());
    _setInitLoadingState(false);
  }
}
