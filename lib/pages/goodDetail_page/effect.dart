import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import '../../redux/Global_Shop_Cart/action.dart';
import '../../redux/Global_Shop_Cart/store.dart';

import '../../services/api.dart';
import '../../utils/net.dart';
import '../../models/goodDetail.dart';

Effect<GoodDetailState> buildEffect() {
  return combineEffects(<Object, Effect<GoodDetailState>>{
    Lifecycle.initState: _loadData,
    GoodDetailAction.action: _onAction,
    // GoodDetailAction.addToCart: _addToCart
  });
}

void _onAction(Action action, Context<GoodDetailState> ctx) {}
// 加载接口数据
void _loadData(Action action, Context<GoodDetailState> ctx) async {
  // print(ctx.state.goodId);
  final _id = ctx.state.goodId;
  // final _id = "42fbd746-ac54-4aed-87ce-fa36866969e0";
  final url = Api.getGoodById.replaceAll(':goodId', _id);
  try {
    final response = await NetUtils.get(url);
    GoodDetailModel goodDetail = GoodDetailModel.fromJson(response["data"]);
    ctx.dispatch(GoodDetailActionCreator.onLoadData(goodDetail));
  } catch (err) {
    print(err);
  }
}

// void _addToCart(Action action, Context<GoodDetailState> ctx) {
//   var goodId = action.payload["goodId"];
//   var goodInfo = action.payload["goodInfo"];

//   GlobalShopCartStore.store.dispatch(
//       GlobalShopCartActionCreator.onAddToCartAction(goodId, goodInfo));
// }
