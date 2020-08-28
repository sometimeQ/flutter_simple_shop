import 'dart:convert';
import 'package:demo1/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import './chat/message_page.dart';
import './personal/personal.dart';
import './modals/IndexData.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './pages/index_page/index_home.dart';
import './pages/category_page/index_home.dart';
import './pages/jiujiu_page/index_home.dart';
import './pages/favorite_page/index_home.dart';
import './pages/user_home_page/index_home.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  UserProvider userProvider;
  static ScrollController mController = new ScrollController();
  static ScrollController jiujiuController =
      new ScrollController(); // 9.9包邮页面滑动控制器

  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  var _currentIndex = 0; //当前选中页面索引

  IndexHome indexHome; // 淘客首页

  CategoryIndexPage categoryIndexPage; // 分类页面

  //聊天页面
  MessagePage message;

  //我的页面
  Personal me;

  // 数据列表
  List<Dtolist> dtoList = [];

  //是否加载中
  bool isLoading = false;

  bool isShowAppBar = true;

  // 页面列表
  List<Widget> _pages = [
    IndexHome(mController: mController),
    JiujiuIndexHome(scrollController: jiujiuController),
    CategoryIndexPage(),
    FavoriteIndexHome(),
    UserIndexHome()
  ];

  //渲染某个菜单项
  _popupMenuItem(String title, {String imagePath, IconData icon}) {
    return PopupMenuItem(
      child: Row(
        children: <Widget>[
          //判断是否使用图片路径还是图标
          imagePath != null
              ? Image.asset(
                  imagePath,
                  width: 32.0,
                  height: 32.0,
                )
              : SizedBox(
                  width: 32.0,
                  height: 32.0,
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
          //显示菜单文本内容
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget loadingWidget() {
    return new Center(
      child: SpinKitCircle(
        color: Colors.blue,
        size: 30.0,
      ),
    );
  }

  Widget _buildAppBar() {
    Widget widget = AppBar(
      leading: Icon(Icons.message),
      title: Container(
        height: ScreenUtil().setHeight(120),
        alignment: Alignment.center,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            hintText: '请输入淘宝复制的标题',
            border: InputBorder.none,
            alignLabelWithHint: true,
            filled: true,
            fillColor: Colors.black12,
            suffixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            hintStyle: TextStyle(
              height: 1,
            ),
          ),
          style: TextStyle(height: 1, color: Colors.black),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 5.0, right: 10.0),
          child: GestureDetector(
            onTap: () {
              //跳转到搜索页面
              Navigator.pushNamed(context, 'search');
            },
            child: Icon(
              Icons.category,
            ),
          ),
        )
      ],
    );

    // 这里写是否显示或者影藏appbar(4--代表用户点击了我的页面)
    if(_currentIndex==4 || _currentIndex==3 || _currentIndex==0 || _currentIndex==1){
      widget = null;
    }

    return widget;
  }

  @override
  void initState() {
//监听滚动事件，打印滚动位置
    mController.addListener(() {
      if (mController.offset < 250 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (mController.offset >= 200 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });

    // 9.9滑动控制器操作
    jiujiuController.addListener(() {
      if (jiujiuController.offset < 250 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (jiujiuController.offset >= 200 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 屏幕适配初始化
    ScreenUtil.init(context, width: 1440, height: 2960, allowFontScaling: true);

    return Scaffold(
      appBar: _buildAppBar(),
      // 滚动到顶部按钮
      floatingActionButton: !showToTopBtn || _currentIndex == 2 || _currentIndex == 3 || _currentIndex==0
      || _currentIndex==4
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward, color: Colors.white),
              onPressed: () {
                //返回到顶部时执行动画
                if (_currentIndex == 0) {
                  mController.animateTo(.0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                }
                if (_currentIndex == 1) {
                  jiujiuController.animateTo(.0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                }
              }),
      bottomNavigationBar: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          //当前页面索引
          currentIndex: _currentIndex,
          //按下后设置当前页面索引
          onTap: ((index) {
            setState(() {
              _currentIndex = index;
            });
          }),
          items: [
            new BottomNavigationBarItem(
                title: new Text(
                  '首页',
                  style: TextStyle(
                      color: _currentIndex == 0
                          ? Color.fromRGBO(253, 87, 92, 1.0)
                          : Color.fromRGBO(102, 102, 102, 1.0)),
                ),
                icon: _currentIndex == 0
                    ? Image.asset(
                        'assets/nav/home.png',
                        width: 32.0,
                        height: 32.0,
                      )
                    : Image.asset(
                        'assets/nav/home-n.png',
                        height: 32.0,
                        width: 32.0,
                      )),
            new BottomNavigationBarItem(
                title: new Text(
                  '9.9包邮',
                  style: TextStyle(
                      color: _currentIndex == 1
                          ? Color.fromRGBO(253, 87, 92, 1.0)
                          : Color.fromRGBO(102, 102, 102, 1.0)),
                ),
                icon: _currentIndex == 1
                    ? Image.asset(
                        'assets/nav/jiujiu.png',
                        width: 32.0,
                        height: 32.0,
                      )
                    : Image.asset(
                        'assets/nav/jiujiu-n.png',
                        height: 32.0,
                        width: 32.0,
                      )),
            new BottomNavigationBarItem(
                title: new Text(
                  '分类',
                  style: TextStyle(
                      color: _currentIndex == 2
                          ? Color.fromRGBO(253, 87, 92, 1.0)
                          : Color.fromRGBO(102, 102, 102, 1.0)),
                ),
                icon: _currentIndex == 2
                    ? Image.asset(
                        'assets/nav/fenlei.png',
                        width: 32.0,
                        height: 32.0,
                      )
                    : Image.asset(
                        'assets/nav/fenlei-n.png',
                        height: 32.0,
                        width: 32.0,
                      )),
            new BottomNavigationBarItem(
                title: new Text(
                  '收藏',
                  style: TextStyle(
                      color: _currentIndex == 3
                          ? Color.fromRGBO(253, 87, 92, 1.0)
                          : Color.fromRGBO(102, 102, 102, 1.0)),
                ),
                icon: _currentIndex == 3
                    ? Image.asset(
                        'assets/nav/shoucang.png',
                        width: 32.0,
                        height: 32.0,
                      )
                    : Image.asset(
                        'assets/nav/shoucang-n.png',
                        height: 32.0,
                        width: 32.0,
                      )),
            new BottomNavigationBarItem(
                title: new Text(
                  '我的',
                  style: TextStyle(
                      color: _currentIndex == 4
                          ? Color.fromRGBO(253, 87, 92, 1.0)
                          : Color.fromRGBO(102, 102, 102, 1.0)),
                ),
                icon: _currentIndex == 4
                    ? Image.asset(
                        'assets/nav/my.png',
                        width: 32.0,
                        height: 32.0,
                      )
                    : Image.asset(
                        'assets/nav/my-n.png',
                        height: 32.0,
                        width: 32.0,
                      )),
          ]),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }
  @override
  void didChangeDependencies() {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    if(this.userProvider!=userProvider){
      this.userProvider = userProvider;
      userProvider.loadUserInfo();
    }
  }
}
