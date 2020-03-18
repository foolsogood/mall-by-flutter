import 'package:fish_redux/fish_redux.dart' as Fish;
import 'package:flutter/material.dart' hide Action;

import '../../models/good.dart';
import '../../redux/Global_Shop_Cart/state.dart';

import '../../models/shopCartModel.dart';


class CartState implements GlobalBaseState, Fish.Cloneable<CartState> {
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
  @override
  CartState clone() {
    return CartState()
      ..totalNumber = totalNumber
      ..totalPrice = totalPrice
      ..shopCart = shopCart
      ..hotGoodsList = hotGoodsList;
  }
}

CartState initState(Map<String, dynamic> args) {
  return CartState();
}