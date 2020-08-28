import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';


class ListItem extends StatelessWidget {

  String title;
  Widget actions;
  Function onTap;
  Widget leftAction;
  bool isCard;

  ListItem({@required this.title,this.actions,@required this.onTap,this.leftAction,this.isCard:false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        height: ScreenUtil().setHeight(200),
        width: ScreenUtil().setWidth(1440),
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(70)),
        margin: isCard ? EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(70)):EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 0.5,color: Colors.black12))
        ),
        child: Row(
          children: <Widget>[

            // 头部
            leftAction != null ? Container(
              child: leftAction,
            ): Container(),


            // 标题
            Expanded(child: Text(title)),

            // 右侧显示
            Container(
              child: actions??Container(
                child: Icon(Icons.chevron_right,color: Colors.black12),
              ),
            )

          ],
        ),
      ),
    );
  }
}
