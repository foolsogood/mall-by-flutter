import 'package:fish_redux/fish_redux.dart';
import 'reducer.dart';
import 'state.dart';

import '../../utils/sqflite/shopcart_dbhelper.dart';
import '../../models/shopCartModel.dart';

class GlobalStore {
  static init() async {
    var dbHelper = ShopCartDBHelper();
    List _list = await dbHelper.getShopCartData();
    print('store constructor');
    Map<String, ShopCartModel> shopCart = {};
    _list.forEach((item) {
      ShopCartModel d = ShopCartModel.fromJson(item);
      shopCart[d.goodId] = d;
    });
    int totalNumber = calcTotalNumAndPrice(shopCart)["totalNumber"];
    int totalPrice = calcTotalNumAndPrice(shopCart)["totalPrice"];
    return Future.value({
      "totalNumber": totalNumber,
      "totalPrice": totalPrice,
      "shopCart": shopCart
    });
  }

  static Store<GlobalState> _globalStore;
  static Store<GlobalState> get store {
    if (_globalStore == null) {
      init().then((res) {
        _globalStore = createStore<GlobalState>(
            GlobalState()
              ..totalNumber = res["totalNumber"]
              ..totalPrice = res["totalPrice"]
              ..shopCart = res["shopCart"],
            buildReducer());
      });
    }
    return _globalStore;
  }
}
