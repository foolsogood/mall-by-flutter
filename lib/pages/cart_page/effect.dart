import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import '../../redux/Global_Shop_Cart/action.dart';
import '../../redux/Global_Shop_Cart/store.dart';

import '../../services/api.dart';
import '../../utils/net.dart';
import '../../models/good.dart';

Effect<CartState> buildEffect() {
  return combineEffects(<Object, Effect<CartState>>{
    Lifecycle.initState: _loadData,
    CartAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CartState> ctx) {}
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
}
