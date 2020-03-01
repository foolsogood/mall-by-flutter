import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import '../../models/good.dart';
import '../../redux/Global_Shop_Cart/state.dart';
import '../../redux/Global_Shop_Cart/store.dart';

import '../../models/shopCartModel.dart';
class CalcState implements GlobalBaseState, Cloneable<CalcState> {
List<GoodModel> hotGoodsList;
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
  String sendTime;
  @override
  CalcState clone() {
    return CalcState()
    ..totalNumber = totalNumber
      ..totalPrice = totalPrice
      ..shopCart = shopCart
      ..hotGoodsList = hotGoodsList
      ..sendTime=sendTime;

  }
}

CalcState initState(Map<String, dynamic> args) {
  return CalcState();
}
