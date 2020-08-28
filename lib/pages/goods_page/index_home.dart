import 'package:demo1/modals/dtkCategorys.dart';
import 'package:demo1/modals/goods_list_modal.dart';
import 'package:demo1/provider/category_provider.dart';
import 'package:demo1/widgets/loading_more_list_indicator.dart';
import 'package:demo1/widgets/waterfall_goods_card.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import '../../util/fluro_convert_util.dart';
import './sort_widget.dart';
import '../../widgets/StickyTabBarDelegate.dart';
import '../../widgets/RoundUnderlineTabIndicator.dart';
import '../../repository/GoodsListRepository.dart';

///

/// 商品列表通用页面

///

class GoodsListPage extends StatefulWidget {
  String subcid;
  String cids;
  String brand;
  String title;
  String showCates; // 是否显示分类选择
  GoodsListPage(
      {this.subcid, this.cids, this.brand, this.title, this.showCates = "0"});

  @override
  _GoodsListPageState createState() => _GoodsListPageState();
}

class _GoodsListPageState extends State<GoodsListPage>
    with TickerProviderStateMixin {
  bool showToTopBtn = false; //是否显示到达顶部按钮
  CategoryProvider categoryProvider;
  bool changeSortIng = false; // 切换排序中
  TabController _tabController; // 排序tab控制器
  TabController categorysTabBarController; //主分类tab控制器
  List<CategoryItem> categorys = [];
  List<Subcategory> showSubcategorys = [];
  GoodsListRepository goodsListRepository;
  List<int> curs = [0, 1, 2, 5, 6];
  int current = 0;
  int priceSortType = 0; // 0:从高到低,1:从低到高
  String initCid; // 分类初始化默认选中
  String currentSubCategory; // 选中的子分类
  String currentMainCategory;// 选中的主分类

  @override
  Widget build(BuildContext context) {
    String t = FluroConvertUtils.fluroCnParamsDecode(widget.title);
    return Consumer<CategoryProvider>(builder: (context, categoryProvider, _) {
      return WillPopScope(
        onWillPop: () async {
          return Future<bool>.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(t),
            leading: BackButton(
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
          body: PullToRefreshNotification(
            pullBackOnRefresh: true,
            maxDragOffset: 80.0,
            onRefresh: () async {
              await goodsListRepository.refresh(true);
              return true;
            },
            child: LoadingMoreCustomScrollView(
              rebuildCustomScrollView: true,
              slivers: <Widget>[
                // 下拉刷新指示头
                PullToRefreshContainer(buildPulltoRefreshHeader),
                //主分类e
                buildTopCategorys(categoryProvider),

                //子分类
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                    ),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 0.8),
                      itemCount: showSubcategorys.length > 10
                          ? 10
                          : showSubcategorys.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return buildSubCategoryItem(showSubcategorys[index]);
                      },
                    ),
                  ),
                ),

                //排序
                SliverPersistentHeader(
                  pinned: true,
                  delegate: StickyTabBarDelegate(
                    child: TabBar(
                        onTap: sortOnChange,
                        labelColor: Colors.pinkAccent,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: Colors.pinkAccent,
                        indicator: RoundUnderlineTabIndicator(
                            borderSide: BorderSide(
                          width: 2,
                          color: Colors.pinkAccent,
                        )),
                        controller: _tabController,
                        tabs: <Widget>[
                          SortWidget(
                            onTap: () => sortOnChange(0),
                            title: "人气",
                            current: current == 0,
                          ),
                          SortWidget(
                            onTap: () => sortOnChange(1),
                            title: "最新",
                            current: current == 1,
                          ),
                          SortWidget(
                            onTap: () => sortOnChange(2),
                            title: "销量",
                            current: current == 2,
                          ),
                          SortWidget(
                              onTap: () => sortOnChange(3),
                              title: "价格",
                              current: current == 3,
                              icon: _bulidPriceIconWidget()),
                        ]),
                  ),
                ),
                // 商品列表
                LoadingMoreSliverList(SliverListConfig<GoodsItem>(
                  sourceList: goodsListRepository,
                  waterfallFlowDelegate: WaterfallFlowDelegate(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, item, index) =>
                      WaterfallGoodsCard(item),
                  indicatorBuilder: (context, state) {
                    return LoadingMoreListCostumIndicator(state,
                        isSliver: true);
                  },
                ))
              ],
            ),
          ),
        ),
      );
    });
  }

  // 子分类布局
  Widget buildSubCategoryItem(Subcategory subcategory) {
    return InkWell(
      onTap: () {
        print("${currentSubCategory}---${subcategory.subcid}");
        if (subcategory.subcid != currentSubCategory) {
          setState(() {
            currentSubCategory = subcategory.subcid.toString();
            currentMainCategory = "";
            this.goodsListRepository = GoodsListRepository(
                cids: "",
                g_sort: "0",
                subcid: subcategory.subcid.toString(),
                brand: "");
          });
          this.goodsListRepository.refresh(true);
          _tabController.animateTo(0);
        }
      },
      child: Container(
        width: ScreenUtil().setWidth(200),
        child: Column(
          children: <Widget>[
            ExtendedImage.network(
              subcategory.scpic,
              width: ScreenUtil().setWidth(200),
              fit: BoxFit.fill,
              cache: true,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            Text(
              subcategory.subcname,
              style: TextStyle(
                  color: currentSubCategory == subcategory.subcid.toString()
                      ? Colors.pinkAccent
                      : Colors.black),
            )
          ],
        ),
      ),
    );
  }

  // 顶部主分类tab
  Widget buildTopCategorys(CategoryProvider categoryProvider) {
    List<Tab> tabs = categorys.map((item) {
      return Tab(text: item.cname);
    }).toList();
    tabs.insert(0, Tab(text: "首页"));
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickyTabBarDelegate(
          child: TabBar(

        onTap: (index) async {
          if (index != 0) {
            setState(() {
              currentMainCategory = categorys[index - 1].cid.toString();
              currentSubCategory = "";
              this.goodsListRepository = GoodsListRepository(
                  cids: categorys[index - 1].cid.toString(),
                  g_sort: "0",
                  subcid: "",
                  brand: "");
            });
            changeSubCategory(index - 1);
            _tabController.animateTo(0);
            await this.goodsListRepository.refresh(true);
          } else {
            Navigator.pop(context);
          }
        },
        controller: categorysTabBarController,
        tabs: categoryProvider.categorys.length != 0 ? tabs : [],
        indicator: RoundUnderlineTabIndicator(
            insets: EdgeInsets.only(bottom: 8),
            borderSide: BorderSide(
              width: 2,
              color: Colors.pinkAccent,
            )),
        unselectedLabelColor: Colors.black,
        labelColor: Colors.pinkAccent,
        isScrollable: true,
      )),
    );
  }

  @override
  void initState() {
    goodsListRepository = GoodsListRepository(
        cids: widget.subcid!=""  ? "" : widget.cids,
        brand: widget.brand,
        subcid: widget.subcid,
        g_sort: "0");
    _tabController = TabController(vsync: this, length: 4);
    categorysTabBarController = TabController(vsync: this, length: 1);
    setState(() {
      currentSubCategory = widget.subcid!=null ? widget.subcid : '';
      currentMainCategory = widget.cids;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var categoryProvider = Provider.of<CategoryProvider>(context);
    if (categoryProvider != this.categoryProvider) {
      this.categoryProvider = categoryProvider;
      setState(() {
        categorys = categoryProvider.categorys;
        categorysTabBarController = TabController(
            length: this.categorys.length + 1,
            vsync: this,
            initialIndex: getInitCategoryTabIndex());
      });
      if (widget.cids != "") {
        changeSubCategory(getInitCategoryTabIndex() - 1);
      }
    }
  }

  // 主分类初始下标获取
  int getInitCategoryTabIndex() {
    var cid = widget.cids;
    for (var item in categorys) {
      if (item.cid.toString() == cid) {
        return categorys.indexOf(item) + 1;
      }
    }
    return 0;
  }

  // 供排序使用
  _setCurrent(int c) {
    setState(() {
      current = c;
    });
  }

  // 价格排序图标改变 (从高到低/从低到高)
  _bulidPriceIconWidget() {
    String iconShow = "assets/icons/px.png";
    if (current == 3) {
      iconShow = "assets/icons/pxx.png";
    }
    if (current == 4) {
      iconShow = "assets/icons/pxs.png";
    }
    return Image.asset(
      iconShow,
      height: ScreenUtil().setHeight(60),
      width: ScreenUtil().setWidth(60),
    );
  }

  // 排序被改变
  sortOnChange(index) async {
    if (index == 3 && priceSortType == 1) {
      _setCurrent(index);
      goodsListRepository = GoodsListRepository(
          cids: currentMainCategory,
          brand: widget.brand,
          subcid: currentSubCategory,
          g_sort: "${index}");
      this.goodsListRepository.refresh(true);
      setState(() {
        priceSortType = 0;
      });
      return;
    }
    if (index == 3 && priceSortType == 0) {
      _setCurrent(4);
      goodsListRepository = GoodsListRepository(
          cids: currentMainCategory,
          brand: widget.brand,
          subcid: currentSubCategory,
          g_sort: "4");
      this.goodsListRepository.refresh(true);
      setState(() {
        priceSortType = 1;
      });
      return;
    }

    if (current != index) {
      _setCurrent(index);
      goodsListRepository = GoodsListRepository(
          cids: currentMainCategory,
          brand: widget.brand,
          subcid: currentSubCategory,
          g_sort: "${index}");
      this.goodsListRepository.refresh(true);
    }
  }

  // 传入主分类的下标
  void changeSubCategory(int index) {
    List<Subcategory> subCates = categorys[index].subcategories;
    setState(() {
      showSubcategorys = subCates;// 网格显示的子分类List
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget buildPulltoRefreshHeader(PullToRefreshScrollNotificationInfo info) {
    //print(info?.mode);
    //print(info?.dragOffset);
    //    print("------------");
    var offset = info?.dragOffset ?? 0.0;
    var mode = info?.mode;
    Widget refreshWiget = Container();
    //it should more than 18, so that RefreshProgressIndicator can be shown fully
    if (info?.refreshWiget != null &&
        offset > 18.0 &&
        mode != RefreshIndicatorMode.error) {
      refreshWiget = info.refreshWiget;
    }

    Widget child = null;
    if (mode == RefreshIndicatorMode.error) {
      child = GestureDetector(
          onTap: () {
            // refreshNotification;
            info?.pullToRefreshNotificationState?.show();
          },
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.bottomCenter,
            height: offset,
            width: double.infinity,
            //padding: EdgeInsets.only(top: offset),
            child: Container(
              padding: EdgeInsets.only(left: 5.0),
              alignment: Alignment.center,
              child: Text(
                "刷新失败,点击重试" ?? "",
                style: TextStyle(fontSize: 12.0, inherit: false),
              ),
            ),
          ));
    } else {
      String modeStr = "下拉刷新";
      if (mode != null && mode == RefreshIndicatorMode.armed) {
        modeStr = "松手刷新";
      } else if (mode != null && mode == RefreshIndicatorMode.snap) {
        modeStr = "请求数据中";
      } else if (mode != null && mode == RefreshIndicatorMode.canceled) {
        modeStr = "操作取消";
      } else if (mode != null && mode == RefreshIndicatorMode.done) {
        modeStr = "刷新成功";
      } else if (mode != null && mode == RefreshIndicatorMode.refresh) {
        modeStr = "正在刷新";
      }
      child = Container(
        color: Colors.transparent,
        alignment: Alignment.bottomCenter,
        height: offset,
        width: double.infinity,
        //padding: EdgeInsets.only(top: offset),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/loading.gif"),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Text(
                "${modeStr}" ?? "",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(50),
                    inherit: false,
                    color: Colors.grey),
              ),
            )
          ],
        ),
      );
    }
    return SliverToBoxAdapter(
      child: child,
    );
  }
}
