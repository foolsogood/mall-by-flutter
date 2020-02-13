import 'package:fish_redux/fish_redux.dart';
import '../../models/shopCartModel.dart';

import 'action.dart';
import 'state.dart';

Reducer<ShopCartState> buildReducer() {
  return asReducer(
    <Object, Reducer<ShopCartState>>{
      ShopCartAction.onAddToCart: _onAddToCartReducer,
    },
  );
}

// 总数量，总价
Map<String, int> calcTotalNumAndPrice(Map<String, ShopCartModel> shopCart) {
  int totalNumber = 0;
  int totalPrice = 0;
  List<ShopCartModel>.from(shopCart.values).forEach((item) {
    totalNumber += item.number;
    totalPrice += item.totalPrice;
  });
  return {"totalNumber": totalNumber, "totalPrice": totalPrice};
}
// 添加进购物车或增加购物车
ShopCartState _onAddToCartReducer(ShopCartState state, Action action) {
  final ShopCartState newState = state.clone();
  var goodId = action.payload.goodId;
  var goodInfo = action.payload.goodInfo;
  var tempShopCart = newState.shopCart;
  bool isExistGoodId = tempShopCart.containsKey(goodId);
  if (isExistGoodId) {
    var price = tempShopCart[goodId].price;
    var number = tempShopCart[goodId].number;
    number++;
    int totalPrice = int.parse(price) * number;
    tempShopCart[goodId].totalPrice = totalPrice;
    tempShopCart[goodId].number = number;
  } else {
    tempShopCart[goodId] = goodInfo;
  }
  int totalNumber = calcTotalNumAndPrice(tempShopCart)["totalNumber"];
  int totalPrice = calcTotalNumAndPrice(tempShopCart)["totalPrice"];
  newState.totalNumber = totalNumber;
  newState.totalPrice = totalPrice;
  newState.shopCart = tempShopCart;
  return newState;
}
