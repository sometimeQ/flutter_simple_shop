import 'package:flutter/material.dart';

class BaseProvider with ChangeNotifier {
  bool loading = false;

//  改变加载状态
  changeLoadingState(bool state) {
    loading = state;
    notifyListeners();
  }
}
