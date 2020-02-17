import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import '../../redux/Global_Shop_Cart/action.dart';
import '../../redux/Global_Shop_Cart/store.dart';

import '../../services/api.dart';
import '../../utils/net.dart';
import '../../models/good.dart';
import '../../utils/sqflite/shopcart_dbhelper.dart';

Effect<CartState> buildEffect() {
  return combineEffects(<Object, Effect<CartState>>{
    Lifecycle.initState: _loadData,
  });
}


// 加载接口数据
void _loadData(Action action, Context<CartState> ctx) async {
  final url = Api.getHotGoods;
  try {
    final response = await NetUtils.get(url);
    // print(response);
    List<GoodModel> hotGoodsList = [];
    for (dynamic data in response['data']) {
      GoodModel newGood = GoodModel.fromJson(data);
      hotGoodsList.add(newGood);
    }
    ctx.dispatch(CartActionCreator.onLoadData(hotGoodsList));
  } catch (err) {
    print(err);
  }

  var dbHelper = ShopCartDBHelper();
  List shopCartData = await dbHelper.getShopCartData();
  print(shopCartData.length);
  GlobalStore.store
      .dispatch(GlobalActionCreator.onInitCartAction(shopCartData));
}
