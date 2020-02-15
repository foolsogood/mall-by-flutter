import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CartPage extends Page<CartState, Map<String, dynamic>> {
  CartPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CartState>(
                adapter: null,
                slots: <String, Dependent<CartState>>{
                }),
            middleware: <Middleware<CartState>>[
            ],);

}
