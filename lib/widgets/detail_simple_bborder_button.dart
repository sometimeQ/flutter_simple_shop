import 'package:flutter/material.dart';

class DetailSimpleBorderButton extends StatelessWidget {
  String text; // 文字
  bool is_current; // 是否选中样式

  DetailSimpleBorderButton({@required this.text, @required this.is_current});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        border:is_current? Border(bottom: BorderSide(color: Colors.pinkAccent,width: 2.0)):null
      ),
      child: Text(text,
      style: TextStyle(
        color: is_current?Colors.pinkAccent:Colors.black,
            fontWeight:is_current?FontWeight.w600:null
      )),
    );
  }
}
