import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CalcPage extends Page<CalcState, Map<String, dynamic>> {
  CalcPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            // dependencies: Dependencies<CalcState>(
            //     adapter: null,
            //     slots: <String, Dependent<CalcState>>{
            //     }),
            // middleware: <Middleware<CalcState>>[
            // ],
            );

}
