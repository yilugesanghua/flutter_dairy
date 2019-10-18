import 'package:date_format/date_format.dart';
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
    Map<String, String> headers,
    CancelToken cancelToken,
    onReceiveProgress(int count, int total),
    failCallBack(int code, String msg),
    onStart(),
    Duration maxAge,
  }) async {
    DioApiStrategy.getInstance().dioFetch(url, "GET", callBack,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        failCallBack: failCallBack ?? (int code, String msg) {},
        headers: headers,
        onStart: onStart,
        maxAge: maxAge);
  }

  void post(
    String url,
    Function callBack, {
    Map data,
    Map<String, String> queryParameters,
    Map headers,
    CancelToken cancelToken,
    onReceiveProgress(int count, int total),
    failCallBack(int code, String msg),
    onStart(),
  }) async {
    DioApiStrategy.getInstance().dioFetch(url, "POST", callBack,
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        failCallBack: failCallBack ?? (int code, String msg) {},
        onStart: onStart);
  }

  void down(
    String url,
    var localPath,
    onReceiveProgress(int count, int total), {
    bool continued = true,
    int startPoint = 0,
    Map queryParameters,
    CancelToken cancelToken,
    onSendProgress(int count, int total),
    failCallBack(int code, String msg),
    onStart(),
  }) async {
    DioApiStrategy.getInstance().dioDown(url, localPath, onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onReceiveProgress,
        failCallBack: failCallBack??(int code,String msg){},
        onStart: onStart);
  }
}
