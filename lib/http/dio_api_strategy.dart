import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_dairy/const/shareprefer_const.dart';
import 'package:flutter_dairy/http/http_config.dart';
import 'package:flutter_dairy/util/env_utl.dart';
import 'package:flutter_dairy/util/network_util.dart';
import 'package:flutter_dairy/util/sharepreference_util.dart';

class DioApiStrategy {
  static DioApiStrategy _instance;
  static HttpConfig _httpConfig;
  Dio _client;
  static const String GET = "get";
  static const String POST = "post";

  get client => _client;

  DioApiStrategy._internal() {
    if (_httpConfig == null) {
      _httpConfig = HttpConfig(15 * 1000, 15 * 1000);
      if (!inProduction) {
        _httpConfig.addInterceptor(
            LogInterceptor(requestBody: true, responseBody: true)); //开启请求日志
      }
      _httpConfig.addInterceptor(
          DioCacheManager(CacheConfig(maxMemoryCacheCount: 1000)).interceptor);
    }

    if (_client == null) {
      BaseOptions baseOptions = new BaseOptions();
      baseOptions.receiveTimeout = _httpConfig.receiveTimeout;
      baseOptions.connectTimeout = _httpConfig.connectTimeout;
      _client = new Dio(baseOptions);
    }
    _httpConfig.interceptors.forEach((ict) {
      _client.interceptors.add(ict);
    });
    //TODO 暂时不设置baseurl
//    if(HttpConfig.baseUrl==null){
//      throw " you must call ";
//    }
  }

  static DioApiStrategy getInstance() {
    if (_instance == null) {
      _instance = DioApiStrategy._internal();
    }
    return _instance;
  }

  void dioFetch(
    String url,
    String method,
    Function callBack, {
    Map headers,
    Map data,
    Map<String, String> queryParameters,
    CancelToken cancelToken,
    onSendProgress(int count, int total),
    onReceiveProgress(int count, int total),
    failCallBack(int code, String msg),
    Duration maxAge,
    onStart(),
  }) async {
    var headerOptions = {HttpHeaders.acceptHeader: "accept: application/json"};
    String token =
        await SharePreferenceUtil.getInstance().getStringValue(TOKEN);
    if (token.isNotEmpty) {
      headerOptions["Authorization"] = token;
    }
    headerOptions.addAll(headers ?? {});
    print("headerOptions:  $headerOptions");
    Options options =
        new Options(headers: headerOptions, method: (method?.toUpperCase()));
    var response;
    try {
      if (method?.toLowerCase() == "post") {
        await onStart();
        response = await _client.post(url,
            data: FormData.fromMap(data),
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress);
      } else {
        await onStart();
        options = buildCacheOptions(maxAge ?? Duration(milliseconds: 0),
            options: options);
        response = await _client.get(url,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress);
      }
    } on DioError catch (e) {
      formatError(e, failCallBack);
      return Future.value();
    } catch (e) {
      if (await isConnected()) {
        await failCallBack(-993, "error request ");
      } else {
        await failCallBack(-992, "no net work");
      }
      return Future.value();
    }
    print("====response.toString()=======${response.toString()}");
    var result = response?.data;
    print("====result=======$result");
    if (result["code"] == 0) {
      await callBack(result["result"]);
    } else {
      await failCallBack(result["code"], result["message"]);
    }
  }

  /**
   * @params  localPath  完整路径
   * @params continued 是否支持断点续传
   */
  void dioDown(
    String url,
    var localPath,
    onReceiveProgress(int count, int total), {
    bool continued = false,
    int startPoint = 0,
    dynamic data,
    var queryParameters,
    CancelToken cancelToken,
    onSendProgress(int count, int total),
    failCallBack(int code, String msg),
    onStart(),
  }) async {
    print("==dioDown== continued: $continued  ,startPoint: $startPoint");
    if (continued) {
      File file = File(localPath);
      if (file.existsSync()) {
        startPoint = await file.length();
      }
    } else {
      File file = File(localPath);
      if (file.existsSync()) {
        file.deleteSync();
      }
    }
    print("==dioDown2== continued: $continued  ,startPoint: $startPoint");
    Options options =
        new Options(headers: {"RANGE": "bytes=$startPoint-"}, method: "GET");
    try {
      onStart();
      await _client.download(
        url,
        localPath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        data: data,
        options: options,
      );
    } on DioError catch (e) {
      formatError(e, failCallBack);
      return Future.value();
    } catch (exception) {
      if (await isConnected()) {
        await failCallBack(-993, "error request ");
      } else {
        await failCallBack(-992, "no net work");
      }
      return Future.value();
    }
  }

  /*
   * error统一处理
   */
  void formatError(DioError e, failCallBack) async {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      await failCallBack(-999, "connet_time_out");
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      await failCallBack(-998, "send_time_out");
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      await failCallBack(-997, "receive_time_out");
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      await failCallBack(e?.response?.statusCode ?? -996, "server error");
      print("出现异常");
      if (e?.response?.statusCode == 401) {
        //TODO 退出登录 (授权失败 登录过期等处理)
      }
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      await failCallBack(-995, "cancel");
      print("请求取消");
    } else {
      if (await isConnected()) {
        await failCallBack(-994, "error request ");
        print("未知错误");
      } else {
        await failCallBack(-992, "no net work");
        print("没有网络");
      }
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.

    }
  }
}
