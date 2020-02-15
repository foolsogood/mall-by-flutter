import 'package:fish_redux/fish_redux.dart';
import '../../models/shopCartModel.dart';

import '../../utils/sqflite/shopcart_dbhelper.dart';

abstract class GlobalShopCartBaseState {
  Map<String, ShopCartModel> get shopCart;
  set shopCart(Map<String, ShopCartModel> map);
  int get totalNumber;
  set totalNumber(int number);
  int get totalPrice;
  set totalPrice(int number);
}

class GlobalShopCartState
    implements GlobalShopCartBaseState, Cloneable<GlobalShopCartState> {
  // 购物车集合
  @override
  Map<String, ShopCartModel> shopCart = {};
  // 总数量
  @override
  int totalNumber = 0;
  // 商品总价格
  @override
  int totalPrice;
  @override
  GlobalShopCartState clone() {
    return GlobalShopCartState()
      ..shopCart = shopCart
      ..totalNumber = totalNumber
      ..totalPrice = totalPrice;
  }
}

GlobalShopCartState initState(Map<String, dynamic> args) {
   final d=_getShopCartData();
   print(d);
  return GlobalShopCartState();
}

Future<List<ShopCartModel>> _getShopCartData() async{
var dbHelper=ShopCartDBHelper();
  Future<List<ShopCartModel>> shopCartData=dbHelper.getShopCartData();
  return shopCartData;
}
