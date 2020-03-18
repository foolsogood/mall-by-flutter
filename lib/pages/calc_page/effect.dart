import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';
import '../../event/event_bus.dart';
import '../../event/event_model.dart';

Effect<CalcState> buildEffect() {
  return combineEffects(<Object, Effect<CalcState>>{
    Lifecycle.initState: init,
  });
}

void init(Action action, Context<CalcState> ctx) async {
  eventBus.on<SendTimeEvent>().listen((onData) {
    print('${onData.time}');
    ctx.dispatch(CalcActionCreator.onSendTime(onData.time));
  });
}


