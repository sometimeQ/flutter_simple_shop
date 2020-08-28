import 'dart:convert';

import 'package:flutter/material.dart';
import '../util/request_service.dart';
import '../modals/dtkCategorys.dart';
import '../widgets/toast_postion.dart';
import '../util/result_obj_util.dart';
import '../modals/Result.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryItem> categorys = [];

  loadDtkCategoryDatas(BuildContext context) async {
    await getDtkCategorys().then((res) {
      Result result = ResultUtils.format(res);
      if (result.code == 200) {
        DtkCategory dtkCategory =
            DtkCategory.fromJson(json.decode(result.data.toString()));
        if (dtkCategory.code == 0) {
          categorys = dtkCategory.data;
          notifyListeners();
        } else {
          Toast.toast(context, msg: "获取分类失败");
        }
      } else {
        Toast.toast(context, msg: "获取分类失败");
      }
    });
  }
}
