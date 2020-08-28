import 'package:demo1/fluro/NavigatorUtil.dart';
import 'package:demo1/pages/user_home_page/order/index.dart';
import 'package:demo1/pages/user_home_page/widgets/list_item.dart';
import 'package:demo1/pages/user_home_page/widgets/svg_title.dart';
import 'package:demo1/provider/user_provider.dart';
import 'package:demo1/util/system_toast.dart';
import 'package:demo1/util/user_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fsuper/fsuper.dart';
import 'package:provider/provider.dart';
import 'header/index.dart';

class UserIndexHome extends StatefulWidget {
  @override
  _IndexHomeState createState() => _IndexHomeState();
}

class _IndexHomeState extends State<UserIndexHome> {
  UserProvider userProvider;
  YYDialog dlog;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) => Scaffold(
        backgroundColor: Color.fromRGBO(245, 246, 250, 1.0),
//        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildHeaderWidget(),
              OrderIndex(),
              SizedBox(height: 10),
              Container(
                child: Column(
                  children: <Widget>[
                    ListItem(
                      title: "订单绑定",
                      onTap: () async {
                        await UserUtil.loadUserInfo().then((user){
                          if(user!=null){
                            NavigatorUtil.gotoOrderAddIndexPage(context);
                          }else{
                            SystemToast.show("请先登录");
                          }
                        });
                      },
                      isCard: true,
                    ),
                    ListItem(
                      title: "帮助反馈",
                      onTap: () {
                        print("前往帮助反馈页面");
                      },
                      isCard: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            dlog = YYDialog().build(context)
              ..borderRadius = 5
              ..width = ScreenUtil().setWidth(700)
              ..height = ScreenUtil().setHeight(520)
              ..widget(Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: ScreenUtil().setHeight(520),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Container(
                      child: Text(
                        "发布",
                        style: TextStyle(fontSize: ScreenUtil().setSp(50)),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SvgTitle(
                            title: "动态",
                            svgPath: "assets/svg/dongtai.svg",
                            onTap: () {
                              dlog.dismiss();
                              NavigatorUtil.goetoWhitePage(context);
                            }),
                        SvgTitle(title: "图文", svgPath: "assets/svg/tuwen.svg"),
                      ],
                    ),
                  ],
                ),
              ))
              ..show();
          },
          backgroundColor: Colors.pinkAccent,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("我的"),
      centerTitle: true,
    );
  }

  Widget _buildHeaderWidget() {
    Widget widget = HeaderIndex(userProvider.user);

    return widget;
  }

  @override
  void didChangeDependencies() {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    if (this.userProvider != userProvider) {
      this.userProvider = userProvider;
      this.userProvider.loadUserInfo();
    }
  }
}
