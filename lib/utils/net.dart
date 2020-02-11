import 'dart:async';
import 'package:dio/dio.dart';

var dio=new Dio(BaseOptions(responseType: ResponseType.json));
class NetUtils {
  // get请求
  static Future get(String url, {Map<String, dynamic> params}) async {
    var response = await dio.get(url, queryParameters: params);
    return response.data;
  }

// post 请求
  static Future post(String url, Map<String, dynamic> params) async {
    var response = await dio.post(url, data: params);
    return response.data;
  }

// form
  static Future postForm(String url, Map<String, dynamic> params) async {
    FormData formData = new FormData.fromMap(params);
    var response = await dio.post(url, data: formData);
    return response.data;
  }
}
