import 'package:fish_redux/fish_redux.dart';
import '../../models/shopCartModel.dart';
//TODO replace with your own action
enum GlobalShopCartAction { onAddToCart }

class GlobalShopCartActionCreator {
  static Action onAddToCartAction(String goodId,ShopCartModel goodInfo) {
    return  Action(
      GlobalShopCartAction.onAddToCart,
      payload: {
        "goodInfo":goodInfo,
        "goodId":goodId
      }
    );
  }
}
