import 'package:flutter/material.dart';

class ScrollControllers {

  static ScrollController jiujiuScrollController(dynamic fun1,dynamic fun2,bool showToTopBtn) {
    ScrollController mController = ScrollController();
    mController.addListener((){
      if (mController.offset < 250 && showToTopBtn) {
        fun1();
      } else if (mController.offset >= 200 && showToTopBtn == false) {
        fun2();
      }
    });
  }
}
