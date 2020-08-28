import 'package:demo1/fluro/NavigatorUtil.dart';
import 'package:demo1/modals/user_model.dart';
import 'package:demo1/widgets/my_clipper.dart';
import 'package:fbutton/fbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fsuper/fsuper.dart';

// 头部容器
class HeaderIndex extends StatelessWidget {
  User user;

  HeaderIndex(this.user);

  // 容器高度
  final int containerHeight = 1000;
  TextStyle subTitleStyle =
      TextStyle(color: Colors.black26, fontSize: ScreenUtil().setSp(50));

  @override
  Widget build(BuildContext context) {
    print("${user}");
    return Container(
      height: ScreenUtil().setHeight(containerHeight),
      child: Stack(
        children: <Widget>[
          ClipPath(
              clipper: MyClipper(),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                height: ScreenUtil().setHeight(containerHeight),
                color: Colors.pink,
              )),
          Container(
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(150),
                left: ScreenUtil().setWidth(70),
                right: ScreenUtil().setWidth(70)),
            height: ScreenUtil().setHeight(300),
            child: Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(850),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(200),
                        height: ScreenUtil().setHeight(200),
                        child: ClipOval(
                          child: user != null
                              ? Image.network(
                                  "${user.avatar != "" ? user.avatar : "http://picbed.demo.saintic.com/static/upload/huang/2020/05/26/15905000070355377.jpg"}",
                                  width: ScreenUtil().setWidth(180),
                                  height: ScreenUtil().setHeight(180),
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "assets/images/ava.jpg",
                                  width: ScreenUtil().setWidth(180),
                                  height: ScreenUtil().setHeight(180),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          height: ScreenUtil().setHeight(200),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    if (user == null) {
                                      NavigatorUtil.gotoUserLoginPage(context);
                                    }
                                  },
                                  child: Text(
                                      user != null
                                          ? "${user.nickname != "" ? user.nickname : "用户@" + user.username}"
                                          : "登录/注册",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: ScreenUtil().setSp(70))),
                                ),
                              ),
                              Container(
                                child: Text("--",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(60),
                                        color: Colors.white)),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(450),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.settings, color: Colors.white),
                            SizedBox(width: 20),
                            Icon(Icons.message, color: Colors.white)
                          ],
                        ),
                      ),
                      Container(
                        child:
                            Text("立即签到", style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: ScreenUtil().setHeight(500),
              width: ScreenUtil().setWidth(1300),
              margin:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(70)),
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(50),
                  vertical: ScreenUtil().setHeight(50)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                children: <Widget>[
                  //第一行
                  Container(
                    height: ScreenUtil().setHeight(100),
                    child: Row(
                      children: <Widget>[
                        Container(child: Text("我的钱包")),
                        Container(child: Text("查看更多>", style: subTitleStyle))
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),

                  //第二行
                  Container(
                    height: ScreenUtil().setHeight(200),
                    child: Row(
                      children: <Widget>[
                        //金额
                        Expanded(
                          child: Container(
                            child: FSuper(
                              spans: <TextSpan>[
                                TextSpan(
                                    text: "- -",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(100),
                                        color: Colors.pinkAccent)),
                                TextSpan(text: "  元")
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: FButton(
                            width: 60,
                            height: 30,
                            padding: EdgeInsets.zero,
                            effect: true,
                            text: "提现",
                            textColor: Colors.white,
                            color: Colors.pinkAccent,
                            onPressed: () {},
                            clickEffect: true,
                            corner: FButtonCorner.all(25),
                          ),
                        )
                      ],
                    ),
                  ),
                  //第三行
                  Container(
                    height: ScreenUtil().setHeight(100),
                    child: Row(
                      children: <Widget>[
                        Container(
                            child: Text(
                          "今日: --",
                          style: subTitleStyle,
                        )),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: Text(
                            "昨日: --",
                            style: subTitleStyle,
                          ),
                        ),
                        Expanded(
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: Text("本月: --", style: subTitleStyle)))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
