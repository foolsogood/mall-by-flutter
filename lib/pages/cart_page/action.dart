import 'package:fish_redux/fish_redux.dart';
import '../../models/good.dart';

//TODO replace with your own action
enum CartAction { action, loadData }

class CartActionCreator {
  static Action onAction() {
    return const Action(CartAction.action);
  }

  static Action onLoadData(List<GoodModel> hotGoodsList) {
    return Action(CartAction.loadData, payload: {"hotGoodsList": hotGoodsList});
  }
}
