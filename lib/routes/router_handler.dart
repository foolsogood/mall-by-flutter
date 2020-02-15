import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/home.dart';
import '../pages/my.dart';
import '../pages/classify.dart';
// import '../pages/cart.dart';

// import '../pages/goodDetail.dart';
import '../pages/order.dart';
import '../pages/goodDetail_page/page.dart';
import '../pages/cart_page/page.dart';



import '../redux/Global_Shop_Cart/state.dart';
import '../redux/Global_Shop_Cart/store.dart';


final homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
  // .buildPage({"11":null});
});
final cartHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CartPage().buildPage({});
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
  final typeId =params["typeId"]?.first;
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
