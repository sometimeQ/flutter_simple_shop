import 'dart:io';

import 'package:flutter/material.dart';
import 'package:demo1/constant/color.dart';
import 'package:demo1/provider/user_provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './app.dart';
import './provider/providers.dart';

// 路由器配置
import 'package:fluro/fluro.dart';
import './fluro/Application.dart';
import './fluro/Routes.dart';
// 路由配置-----end

void main() {
  // 定义路由
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;

  runApp(MyApp());

//  if(Platform.isAndroid){
//    SystemUiOverlayStyle style = SystemUiOverlayStyle(
//        statusBarColor: Colors.black12,
//        ///这是设置状态栏的图标和字体的颜色
//        ///Brightness.light  一般都是显示为白色
//        ///Brightness.dark 一般都是显示为黑色
//        statusBarIconBrightness: Brightness.light
//    );
//    SystemChrome.setSystemUIOverlayStyle(style);
//  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '典典小卖部',
          //自定义主题
          theme: myDefaultTheme,
          // 声明路由
          onGenerateRoute: Application.router.generator,
          home: new App(),
        ),
      ),
    );
  }
}

//自定义主题,绿色小清新风格
final ThemeData myDefaultTheme = new ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Color(0xFFebebeb),
    cardColor: Colors.green
);


