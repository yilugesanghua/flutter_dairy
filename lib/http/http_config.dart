import 'package:dio/dio.dart';

class HttpConfig {
  HttpConfig._internal();

  HttpConfig(int connectTimeout, int receiveTimeout) {
    _connectTimeout = connectTimeout;
    _receiveTimeout = receiveTimeout;
  }

  //网络拦截器
  Interceptors _interceptors;

  //连接超时
  int _connectTimeout = 15 * 1000;

  //接收超时
  int _receiveTimeout = 15 * 1000;

  //TODO 目前不配置baseUrl => 必须初始化配置  否则抛出异常
  String _baseUrl;

  get baseUrl => _baseUrl;

  set baseUrl(baseUrl) {
    _baseUrl = baseUrl;
  }

  get connectTimeout => _connectTimeout;

  set connectTimeout(connectTimeout) {
    _connectTimeout = connectTimeout;
  }

  get receiveTimeout => _receiveTimeout;

  set receiveTimeout(receiveTimeout) {
    _receiveTimeout = receiveTimeout;
  }

  Interceptors get interceptors => _interceptors;

  void addInterceptor(Interceptor interceptor) {
    if (_interceptors == null) {
      _interceptors = new Interceptors();
    }
    _interceptors.add(interceptor);
  }
}
