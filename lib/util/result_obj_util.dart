import '../modals/Result.dart';
import 'dart:convert';

class ResultUtils {
  // 远程数据
  static Result format(res) {
    return Result.fromJson(json.decode(res.toString()));
  }
}
