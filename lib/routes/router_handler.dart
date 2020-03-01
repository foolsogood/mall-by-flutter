import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:fluro/fluro.dart';
import '../pages/home.dart';
import '../pages/my.dart';
import '../pages/classify.dart';

// import '../pages/goodDetail.dart';
import '../pages/order.dart';
import '../pages/goodDetail_page/page.dart';
import '../pages/cart_page/page.dart';
import '../pages/calc_page/page.dart';
import '../pages/sendTime.dart';


import '../redux/Global_Shop_Cart/state.dart';
import '../redux/Global_Shop_Cart/store.dart';

final homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
  // .buildPage({"11":null});
});
final cartHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var page = CartPage();
  bool flag = page.isTypeof<GlobalBaseState>();
  if (flag) {
    page.connectExtraStore<GlobalState>(GlobalStore.store,
        (Object pagestate, GlobalState appState) {
      if (pagestate is Cloneable) {
        final Object copy = pagestate.clone();
        final GlobalBaseState newState = copy;
        newState.shopCart = appState.shopCart;
        newState.totalNumber = appState.totalNumber;
        newState.totalPrice = appState.totalPrice;
        newState.themeColor = appState.themeColor;

        return newState;
      }
      // }
      return pagestate;
    });
  }
  return page.buildPage({});
});
final calcHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var page = CalcPage();
  bool flag = page.isTypeof<GlobalBaseState>();
  print('flag is $flag');
  if (flag) {
    page.connectExtraStore<GlobalState>(GlobalStore.store,
        (Object pagestate, GlobalState appState) {
      if (pagestate is Cloneable) {
        final Object copy = pagestate.clone();
        final GlobalBaseState newState = copy;
        newState.shopCart = appState.shopCart;
        newState.totalNumber = appState.totalNumber;
        newState.totalPrice = appState.totalPrice;
        newState.themeColor = appState.themeColor;

        return newState;
      }
      // }
      return pagestate;
    });
  }
  return page.buildPage({});
});
final classifyHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ClassifyPage();
});
final myHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MyPage();
});
final orderHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  // 相当于params["typeId"]？params["typeId"].first：null
  final typeId = params["typeId"]?.first;
  if (typeId == null) {
    return OrderPage();
  }
  return OrderPage(typeId: typeId);
});
final goodDetailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  final goodId = params["goodId"].first;
  return GoodDetailPage().buildPage({"goodId": goodId.toString()});
  // return GoodDetailPage(goodId: goodId.toString());
});
final sendTimeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SendTimePage();
});