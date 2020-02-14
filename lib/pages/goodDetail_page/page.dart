import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GoodDetailPage extends Page<GoodDetailState, Map<String, dynamic>> {
  GoodDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GoodDetailState>(
                adapter: null,
                slots: <String, Dependent<GoodDetailState>>{
                }),
            middleware: <Middleware<GoodDetailState>>[
            ],);

}
