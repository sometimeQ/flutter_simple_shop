import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../modals/dtkCategorys.dart';

class LeftWidgetItem extends StatelessWidget {
  CategoryItem item;
  bool is_current;

  LeftWidgetItem({this.item, this.is_current});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(150),
      alignment: Alignment.center,
      decoration:
          BoxDecoration(color: is_current ? Colors.white : Color.fromRGBO(248, 248, 248, 1.0)),
      child: Text(
        item.cname,
        style: TextStyle(color: is_current ? Colors.pinkAccent : Colors.black),
      ),
    );
  }
}
