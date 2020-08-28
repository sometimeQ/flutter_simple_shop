import 'dart:convert';
import 'package:demo1/modals/Result.dart';
import 'package:demo1/util/result_obj_util.dart';
import 'package:demo1/util/system_toast.dart';
import 'package:dio/dio.dart';

final String BASE_URL = "http://itbug.shop:8081/api/"; // 网络请求
final String LOCALHOST_RUL = "http://192.168.43.44:8081/api/"; // 本地请求
final String LOCALHOST_RUL2 = "http://192.168.43.185:8081/api/"; // 本地请求2
final String NET = "http://itbug.free.idcfengye.com/api/"; // 隧道
final String t = "http://192.168.0.105:8081/api/"; //

Future get(apiName, {dynamic data}) {
  return request(apiName, data: data, method: "GET");
}

Future post(apiName, {dynamic data}) {
  return request(apiName, data: data, method: "POST");
}


String formatUrl(String apiName) {
  return LOCALHOST_RUL + apiName;
}

Future request(apiName, {dynamic data, String method}) async {
  try {
    Response response;
    Dio dio = Dio();
    response = await dio.request(
      formatUrl(apiName),
      data: data,
      options: Options(
          method: method ?? 'GET',
          responseType: ResponseType.json,
          responseDecoder: (List<int> responseBytes, RequestOptions options,
              ResponseBody responseBody) {
            Utf8Decoder utf8decoder = new Utf8Decoder();
            String d = utf8.decode(responseBytes);
//            Result result = ResultUtils.format(json.decode(d).toString());
//            if(result.code!=200){
//              SystemToast.show(result.msg);
//            }
            return utf8decoder.convert(responseBytes);
          }),
    );


    if (response.statusCode == 200) {
      return response;
    } else {
      print('加载失败');
    }
  } on DioError catch (e) {
    print("错误:${e.error}");
    SystemToast.show(e.error.toString());
  }
}

