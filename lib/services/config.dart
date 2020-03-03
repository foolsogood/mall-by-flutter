enum Env {
  PROD,
  LOCAL,
  MOCK,
}

class Config {
  static Env env;
  static String get getServer {
    if (env == Env.MOCK) {
      return '';
    }
    if (env == Env.PROD) {
      return '';//TODO
    }
    // 默认返回本地环境
    return 'http://127.0.0.1:7001';
  }
}
