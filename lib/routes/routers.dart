import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes {
  static String home = "/home";
  static String classify = "/classify";
  static String cart = "/cart";
  static String my = "/my";
  static String order = "/order";

  static String goodDetail = "/goodDetail";
  static String calc = "/calc";
  static String sendTime = "/sendTime";
  static String search = "/search";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('404');
    });
    router.define(home, handler: homeHandler);
    router.define(cart, handler: cartHandler);
    router.define(classify, handler: classifyHandler);
    router.define(my, handler: myHandler);
    router.define(order, handler: orderHandler);

    router.define(goodDetail, handler: goodDetailHandler);
    router.define(calc, handler: calcHandler);
    router.define(sendTime, handler: sendTimeHandler);
    router.define(search, handler: searchHandler);
  }
}
