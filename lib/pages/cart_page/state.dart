import 'package:fish_redux/fish_redux.dart';
import '../../models/good.dart';

class CartState implements Cloneable<CartState> {
  List<GoodModel> hotGoodsList;
  @override
  CartState clone() {
    return CartState()..hotGoodsList = hotGoodsList;
  }
}

CartState initState(Map<String, dynamic> args) {
  return CartState();
}
