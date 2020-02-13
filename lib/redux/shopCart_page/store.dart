import 'package:fish_redux/fish_redux.dart';
import 'reducer.dart';
import 'state.dart';
class ShopCartStore{
  static Store<ShopCartStore> _store;
  static Store<ShopCartStore> get store=>_store??createStore<ShopCartState>(ShopCartState(), buildReducer());
}