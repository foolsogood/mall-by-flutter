import 'package:fish_redux/fish_redux.dart';
import '../../models/goodDetail.dart';
import '../../models/shopCartModel.dart';

//TODO replace with your own action
enum GoodDetailAction { action, loadData }

class GoodDetailActionCreator {
  static Action onAction() {
    return const Action(GoodDetailAction.action);
  }

  static Action onLoadData(GoodDetailModel goodDetail) {
    return Action(GoodDetailAction.loadData,
        payload: {"goodDetail": goodDetail});
  }

  // static Action onAddToCart(String goodId, ShopCartModel goodInfo) {
  //   return Action(GoodDetailAction.addToCart,
  //       payload: {"goodInfo": goodInfo, "goodId": goodId});
  // }
}
