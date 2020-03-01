import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CalcAction { action , sendTime}

class CalcActionCreator {
  static Action onAction() {
    return const Action(CalcAction.action);
  }
  static Action onSendTime(String sendTime) {
    return  Action(CalcAction.sendTime,
    payload: {
      "sendTime":sendTime
    });
  }
}
