import 'package:fish_redux/fish_redux.dart';

import '../../models/shopCartModel.dart';
import '../../event/event_bus.dart';
import '../../event/event_model.dart';
import 'action.dart';
import 'state.dart';

import '../../utils/sqflite/shopcart_dbhelper.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.onAddToCart: _onAddToCartReducer,
      GlobalAction.onInitCart: _onInitCartReducer,
      GlobalAction.onUpdateCart: _onUpdateCartReducer,
      GlobalAction.onDeleteCart: _onDeleteCartReducer,
    },
  );
}

// 总数量，总价
Map<String, int> calcTotalNumAndPrice(Map<String, ShopCartModel> shopCart) {
  int totalNumber = 0;
  int totalPrice = 0;
  List<ShopCartModel>.from(shopCart.values)
  // 过滤掉未勾选
      .where((item) => item.isSelected == 1)
      .forEach((item) {
    totalNumber += item.number;
    totalPrice += item.totalPrice;
  });
  return {"totalNumber": totalNumber, "totalPrice": totalPrice};
}

GlobalState _onInitCartReducer(GlobalState state, Action action) {
  final GlobalState newState = state.clone();
  List _list = action.payload["dbData"];
  Map<String, ShopCartModel> tempShopCart = {};
  _list.forEach((item) {
    ShopCartModel d = ShopCartModel.fromJson(item);
    tempShopCart[d.goodId] = d;
  });
  int totalNumber = calcTotalNumAndPrice(tempShopCart)["totalNumber"];
  int totalPrice = calcTotalNumAndPrice(tempShopCart)["totalPrice"];
  newState.totalNumber = totalNumber;
  newState.totalPrice = totalPrice;
  newState.shopCart = tempShopCart;
  return newState;
}

// 添加进购物车或增加购物车
GlobalState _onAddToCartReducer(GlobalState state, Action action) {
  var dbHelper = ShopCartDBHelper();
  final GlobalState newState = state.clone();
  var goodId = action.payload["goodId"];
  var goodInfo = action.payload["goodInfo"];
  var tempShopCart = state.shopCart ?? {};
  bool isExistGoodId = tempShopCart.containsKey(goodId);
  //如果购物车有该商品 则更新商品，反之则插入商品
  if (isExistGoodId) {
    var price = tempShopCart[goodId].price;
    var number = tempShopCart[goodId].number;
    number++;
    int totalPrice = price * number;
    tempShopCart[goodId].totalPrice = totalPrice;
    tempShopCart[goodId].number = number;
    dbHelper.updateCart(tempShopCart[goodId]);
    eventBus.fire(ShowToastEvent('show', '已经在购物车'));
  } else {
    tempShopCart[goodId] = goodInfo;
    dbHelper.insertCart(goodInfo);
    eventBus.fire(ShowToastEvent('show', '加入购物车'));
  }
  int totalNumber = calcTotalNumAndPrice(tempShopCart)["totalNumber"];
  int totalPrice = calcTotalNumAndPrice(tempShopCart)["totalPrice"];
  newState.totalNumber = totalNumber;
  newState.totalPrice = totalPrice;
  newState.shopCart = tempShopCart;
  return newState;
}

// 更新购物车 商品数量或勾选变化
GlobalState _onUpdateCartReducer(GlobalState state, Action action) {
  var dbHelper = ShopCartDBHelper();
  final GlobalState newState = state.clone();
  var goodId = action.payload["goodId"];
  var number = action.payload["number"];
  var isSelected = action.payload["isSelected"];
  var tempShopCart = state.shopCart;
  var _curGood = tempShopCart[goodId];
  var price = _curGood.price;
  int _curTotalPrice = price * number;
  // print('===$_curTotalPrice');
  _curGood.totalPrice = _curTotalPrice;
  _curGood.number = number;
  _curGood.isSelected = isSelected;
  dbHelper.updateCart(_curGood);
  tempShopCart[goodId] = _curGood;
  int totalNumber = calcTotalNumAndPrice(tempShopCart)["totalNumber"];
  int totalPrice = calcTotalNumAndPrice(tempShopCart)["totalPrice"];
  newState.totalNumber = totalNumber;
  newState.totalPrice = totalPrice;
  newState.shopCart = tempShopCart;
  return newState;
}

// 删除购物车item
GlobalState _onDeleteCartReducer(GlobalState state, Action action) {
  var dbHelper = ShopCartDBHelper();
  final GlobalState newState = state.clone();
  var goodId = action.payload["goodId"];
  var delRes = dbHelper.deleteCart(goodId);
  print(delRes);
  var tempShopCart = state.shopCart;
  tempShopCart.remove(goodId);
  int totalNumber = calcTotalNumAndPrice(tempShopCart)["totalNumber"];
  int totalPrice = calcTotalNumAndPrice(tempShopCart)["totalPrice"];
  newState.totalNumber = totalNumber;
  newState.totalPrice = totalPrice;
  newState.shopCart = tempShopCart;
  return newState;
}
