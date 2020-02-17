import 'package:fish_redux/fish_redux.dart';
import '../../models/shopCartModel.dart';

//TODO replace with your own action
enum GlobalAction {
  onInitCart,
  onAddToCart,
  onUpdateCart,
  onDeleteCart
}

class GlobalActionCreator {
  static Action onAddToCartAction(String goodId, ShopCartModel goodInfo) {
    return Action(GlobalAction.onAddToCart,
        payload: {"goodInfo": goodInfo, "goodId": goodId});
  }

  static Action onUpdateCartAction(String goodId, int number,int isSelected) {
    return Action(GlobalAction.onUpdateCart,
        payload: {"goodId": goodId, "number": number,"isSelected":isSelected});
  }
static Action onDeleteCartAction(String goodId,) {
    return Action(GlobalAction.onDeleteCart,
        payload: {"goodId": goodId, });
  }
  static Action onInitCartAction(List dbData) {
    return Action(GlobalAction.onInitCart, payload: {
      "dbData": dbData,
    });
  }
}
