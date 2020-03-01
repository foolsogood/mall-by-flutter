import 'package:event_bus/event_bus.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';
import '../../redux/Global_Shop_Cart/action.dart';
import '../../redux/Global_Shop_Cart/store.dart';

import '../../services/api.dart';
import '../../utils/net.dart';
import '../../models/good.dart';
import '../../utils/sqflite/shopcart_dbhelper.dart';
import '../../event/event_bus.dart';
import '../../event/event_model.dart';

Effect<CalcState> buildEffect() {
  return combineEffects(<Object, Effect<CalcState>>{
    Lifecycle.initState: init,
  });
}

void init(Action action, Context<CalcState> ctx) async {
  _loadData(action, ctx);
  eventBus.on<SendTimeEvent>().listen((onData) {
    print('${onData.time}');
    ctx.dispatch(CalcActionCreator.onSendTime(onData.time));
  });
}

void _loadData(Action action, Context<CalcState> ctx) async {
  var dbHelper = ShopCartDBHelper();
  List shopCartData = await dbHelper.getShopCartData();
  print(shopCartData.length);
  GlobalStore.store
      .dispatch(GlobalActionCreator.onInitCartAction(shopCartData));
}
