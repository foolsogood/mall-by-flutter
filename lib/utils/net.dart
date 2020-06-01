import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../services/config.dart';
import '../mock/mockServer.dart';
import '../event/event_bus.dart';
import '../event/event_model.dart';

var dio = new Dio(BaseOptions(responseType: ResponseType.json));

class NetUtils {
  // get请求
  static Future get(String url, {Map<String, dynamic> params}) async {
    eventBus.fire(LoadingEvent('show', 'loading'));
    // mock 环境
    if (Config.env == Env.MOCK) {
      // print(' current env is ${Config.env}');
      eventBus.fire(LoadingEvent('hide', ''));
      return MockServer().getData(url);
    }
    var response = await dio.get(url, queryParameters: params);
    eventBus.fire(LoadingEvent('hide', ''));
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
