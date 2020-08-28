import 'package:flutter/material.dart';

// 资源未找到
class NotFoundPage extends StatelessWidget {
  String title;
  String desc;

  NotFoundPage({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title??'404'),
      ),
      body: Container(
        child: Text(desc??'资源未找到!'),
      ),
    );
  }
}
