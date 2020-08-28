import 'package:demo1/util/system_toast.dart';
import 'package:demo1/widgets/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuIcon extends StatelessWidget {
  int index;
  Function onTap;

  MenuIcon(this.index,{this.onTap});

  @override
  Widget build(BuildContext context) {
    return _buildWidgetByIndex(index);
  }

  Widget _buildWidgetByIndex(index) {
    Widget widget = Container();
    if (index == 0) {
      widget = _item("疯抢排行",
          "https://img.alicdn.com/imgextra/i2/2053469401/O1CN01cd4Sbe2JJi0BtsCQ9_!!2053469401.png");
    }
    if (index == 1) {
      widget = _item("9.9包邮",
          "https://img.alicdn.com/imgextra/i4/2053469401/O1CN01yAF5em2JJi03dO5Rt_!!2053469401.png");
    }
    if (index == 2) {
      widget = _item("品牌特卖",
          "https://img.alicdn.com/imgextra/i4/2053469401/O1CN01Kl54Hm2JJi0M4oJzL_!!2053469401.png");
    }
    if (index == 3) {
      widget = _item("每日半价",
          "https://img.alicdn.com/imgextra/i4/2053469401/O1CN01VHkeLW2JJi03dNHba_!!2053469401.png");
    }
    if (index == 4) {
      widget = _item("折上折",
          "https://img.alicdn.com/imgextra/i2/2053469401/O1CN01cUcsnS2JJi03dPxrH_!!2053469401.png");
    }
    return widget;
  }

  Widget _item(String title, String src) {
    return InkWell(
      onTap: onTap??(){
        SystemToast.show("功能未开发");
      },
      child: Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            ClipOval(
              child: ExtendedImageWidget(
                src: src,
                width: 230,
                height: 230,
                fit: BoxFit.cover,
              ),
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}

//        children<Widget>[
//          _item("疯抢排行",
//              "https://img.alicdn.com/imgextra/i3/2053469401/O1CN01aQpA9S2JJi0NslMQb_!!2053469401.gif")
//        ],
//        children: <Widget>[
//          // 第一行
//          _item("疯抢排行",
//              "https://img.alicdn.com/imgextra/i3/2053469401/O1CN01aQpA9S2JJi0NslMQb_!!2053469401.gif"),
//          _item("9.9包邮",
//              "https://img.alicdn.com/imgextra/i4/2053469401/O1CN01yAF5em2JJi03dO5Rt_!!2053469401.png"),
//          _item("品牌特卖",
//              "https://img.alicdn.com/imgextra/i3/2053469401/O1CN016LSPRa2JJi06FDPGB_!!2053469401.gif"),
//          _item("每日半价",
//              "https://img.alicdn.com/imgextra/i4/2053469401/O1CN01VHkeLW2JJi03dNHba_!!2053469401.png"),
//          _item("折上折",
//              "https://img.alicdn.com/imgextra/i2/2053469401/O1CN01cUcsnS2JJi03dPxrH_!!2053469401.png"),

// 第二行
//          _item("阿里健康",
//              "https://img.alicdn.com/imgextra/i1/2053469401/O1CN01RLtQDC2JJhzzrcYQ1_!!2053469401.png"),
//          _item("口碑",
//              "https://img.alicdn.com/imgextra/i4/2053469401/O1CN01Kl54Hm2JJi0M4oJzL_!!2053469401.png"),
//          _item("饿了么",
//              "https://img.alicdn.com/imgextra/i3/2053469401/O1CN011PKStB2JJi01MxH6f_!!2053469401.gif"),
//          _item("生活影视",
//              "https://img.alicdn.com/imgextra/i2/2053469401/O1CN01X8iL1T2JJi03pYgE1_!!2053469401.png"),
//          _item("限时爆品",
//              "https://img.alicdn.com/imgextra/i2/2053469401/O1CN01cd4Sbe2JJi0BtsCQ9_!!2053469401.png"),
//        ],
