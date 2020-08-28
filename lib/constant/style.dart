import 'package:flutter/material.dart';

var boxShaow = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.3),
    offset: Offset(0.5, 0.5), //阴影xy轴偏移量
    blurRadius: 3.0, //阴影模糊程度
    spreadRadius: 1 //阴影扩散程度
);