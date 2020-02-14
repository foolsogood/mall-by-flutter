import 'package:fish_redux/fish_redux.dart';
import '../../models/shopCartModel.dart';

import 'action.dart';
import 'state.dart';

Reducer<GlobalShopCartState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalShopCartState>>{
      GlobalShopCartAction.onAddToCart: _onAddToCartReducer,
    },
  );
}

// 总数量，总价
Map<String, int> calcTotalNumAndPrice(Map<String, ShopCartModel> shopCart) {
  int totalNumber = 0;
  int totalPrice = 0;
  List<ShopCartModel>.from(shopCart.values).forEach((item) {
    print(item.number);
    print(item.totalPrice);
    totalNumber += item.number;
    totalPrice += item.totalPrice;
  });
  return {"totalNumber": totalNumber, "totalPrice": totalPrice};
}
// 添加进购物车或增加购物车
GlobalShopCartState _onAddToCartReducer(GlobalShopCartState state, Action action) {
  final GlobalShopCartState newState = state.clone();
  var goodId = action.payload["goodId"];
  var goodInfo = action.payload["goodInfo"];
  var tempShopCart = newState.shopCart;
  bool isExistGoodId = tempShopCart.containsKey(goodId);
  if (isExistGoodId) {
    var price = tempShopCart[goodId].price;
    var number = tempShopCart[goodId].number;
    number++;
    int totalPrice = price * number;
    print('===$totalPrice');
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
