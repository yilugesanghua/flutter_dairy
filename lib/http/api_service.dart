import 'package:dio/dio.dart';
import 'package:flutter_dairy/http/dio_api_strategy.dart';

class APiService {
  factory APiService() => _getInstance();

  static APiService get instance => _getInstance();
  static APiService _instance;

  APiService._internal() {
    ///初始化
  }

  static APiService _getInstance() {
    if (_instance == null) {
      _instance = new APiService._internal();
    }
    return _instance;
  }

  void get(
    String url,
    Function callBack, {
    Map queryParameters,
    CancelToken cancelToken,
    onReceiveProgress(int count, int total),
    failCallBack(int code, String msg),
  }) async {
    DioApiStrategy.getInstance().dioFetch(url, "GET", callBack,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        failCallBack: failCallBack);
  }

  void post(
    String url,
    Function callBack, {
    Map data,
    Map queryParameters,
    CancelToken cancelToken,
    onReceiveProgress(int count, int total),
    failCallBack(int code, String msg),
  }) async {
    DioApiStrategy.getInstance().dioFetch(url, "POST", callBack,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        failCallBack: failCallBack);
  }

  void down(
    String url,
    var localPath,
    onReceiveProgress(int count, int total), {
    Map queryParameters,
    CancelToken cancelToken,
    onSendProgress(int count, int total),
    failCallBack(int code, String msg),
  }) async {
    DioApiStrategy.getInstance().dioDown(url, localPath, onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onReceiveProgress,
        failCallBack: failCallBack);
  }
}
