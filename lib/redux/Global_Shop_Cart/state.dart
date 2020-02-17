import 'package:fish_redux/fish_redux.dart' as Fish;
import 'package:flutter/material.dart';
import '../../models/shopCartModel.dart';


abstract class GlobalBaseState {
  Map<String, ShopCartModel> get shopCart;
  set shopCart(Map<String, ShopCartModel> map);
  int get totalNumber;
  set totalNumber(int number);
  int get totalPrice;
  set totalPrice(int number);
  Color get themeColor;
  set themeColor(Color color);
}

class GlobalState
    implements GlobalBaseState, Fish.Cloneable<GlobalState> {
  // 购物车集合
  @override
  Map<String, ShopCartModel> shopCart;
  // 总数量
  @override
  int totalNumber;
  // 商品总价格
  @override
  int totalPrice;

  @override
  Color themeColor;
  @override
  GlobalState clone() {
    return GlobalState();
  }
}

GlobalState initState(Map<String, dynamic> args) {
  return GlobalState();
}

