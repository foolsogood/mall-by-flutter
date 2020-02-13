import 'package:fish_redux/fish_redux.dart';
import '../../models/shopCartModel.dart';
class ShopCartState implements Cloneable<ShopCartState> {
  // 购物车集合
  Map<String,ShopCartModel> shopCart={};
  // 总数量
  int totalNumber=0;
  // 商品总价格
  int totalPrice=0;
  @override
  ShopCartState clone() {
    return ShopCartState()
    ..shopCart=shopCart
    ..totalNumber=totalNumber
    ..totalPrice=totalPrice;
  }
}

ShopCartState initState(Map<String, dynamic> args) {
  return ShopCartState();
}
