import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fbutton/fbutton.dart';
import 'package:fsuper/fsuper.dart';
import 'package:provider/provider.dart';
import '../../../provider/user_provider.dart';

// 用户登入页面
class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  bool isAgree = false; // 是否同意协议
  String username = ""; // 用户名
  String password = ""; // 密码
  bool loading = false;// 是否登录中
  UserProvider userProvider;// 用户状态管理

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Center(
              child: Text("注册账号",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500)),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                //   Logo
                Container(
                  child: Center(
                    child: Container(
                        width: ScreenUtil().setWidth(200),
                        height: ScreenUtil().setHeight(200),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Image.asset("assets/images/logo.png")),
                  ),
                ),

                // 间隔
                SizedBox(height: 40),

                //表单

                Container(
                  width: ScreenUtil().setWidth(1300),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: <Widget>[
                      // 用户名输入框
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "手机号/邮箱",
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                        ),
                        onChanged: (val){
                          setState(() {
                            username = val;
                          });
                        },
                      ),

                      // 密码输入框
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "密码",
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                        ),
                        onChanged: (val){
                          setState(() {
                            password = val;
                          });
                        },
                      )
                    ],
                  ),
                ),

                // 间隔
                SizedBox(height: 40),
                FButton(
                  width: ScreenUtil().setWidth(1300),
                  effect: true,
                  text: "登录",
                  textColor: Colors.white,
                  color: Colors.pink,
                  loading: loading,
                  onPressed: () async{
                    bool isLoginSuccess = await this.userProvider.login(username, password);
                    if(isLoginSuccess){
                      Navigator.pop(context);
                    }
                    setState(() {
                      loading = false;
                    });
                  },
                  clickEffect: true,
                  corner: FButtonCorner.all(0),
                  loadingSize: 15,
                  imageMargin: 6,
                  loadingStrokeWidth: 2,
                  clickLoading: true,
                  loadingColor: Colors.white,
                  loadingText: "正在登录...",
                  imageAlignment: ImageAlignment.left,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            child: Container(
              width: ScreenUtil().setWidth(1440),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          isAgree = !isAgree;
                        });
                      },
                      child: Image.asset(
                        isAgree
                            ? "assets/icons/select.png"
                            : "assets/icons/select_no.png",
                        height: ScreenUtil().setHeight(58),
                        width: ScreenUtil().setWidth(58),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: FSuper(
                        text: "我已阅读并同意",
                        textColor: Colors.white,
                        spans: [
                          TextSpan(
                              text: "用户协议",
                              style: TextStyle(
                                  decoration: TextDecoration.underline)),
                          TextSpan(text: "和", style: TextStyle()),
                          TextSpan(
                              text: "隐私政策",
                              style: TextStyle(
                                  decoration: TextDecoration.underline)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    UserProvider userProvider =  Provider.of<UserProvider>(context);
    if(this.userProvider!=userProvider){
      this.userProvider = userProvider;
    }
  }
}
