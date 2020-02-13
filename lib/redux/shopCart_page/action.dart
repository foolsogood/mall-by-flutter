import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ShopCartAction { onAddToCart }

class ShopCartActionCreator {
  static Action onAddToCartAction(String goodId,Map<String,dynamic> goodInfo) {
    return  Action(
      ShopCartAction.onAddToCart,
      payload: {
        goodInfo:goodInfo,
        goodId:goodId
      }
    );
  }
}
