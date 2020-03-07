// 事件集中管理 中介者
class SendTimeEvent {
  final String time;
  SendTimeEvent(this.time);
}

class ShowToastEvent {
  final String type;
  final String msg;
  ShowToastEvent(this.type, this.msg);
}
enum LoadingType{
  Show,
  Hide
}
class LoadingEvent {
  final String type;
  final String msg;
  LoadingEvent(this.type, this.msg);
}
