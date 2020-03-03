import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';
import '../services/config.dart';
import '../mock/mockServer.dart';

var dio = new Dio(BaseOptions(responseType: ResponseType.json));

class NetUtils {
  // get请求
  static Future get(String url, {Map<String, dynamic> params}) async {
    // showToast("content");
    // mock 环境
    if (Config.env == Env.MOCK) {
      print(' current env is ${Config.env}');
      return MockServer().getData(url);
    }
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
