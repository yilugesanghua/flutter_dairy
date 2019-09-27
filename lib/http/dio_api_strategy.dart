import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_dairy/http/http_config.dart';
import 'package:flutter_dairy/util/env_utl.dart';
import 'package:flutter_dairy/util/network_util.dart';

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
    Map data,
    var queryParameters,
    CancelToken cancelToken,
    onSendProgress(int count, int total),
    onReceiveProgress(int count, int total),
    failCallBack(int code, String msg),
  }) async {
    Options options = new Options(
        headers: {HttpHeaders.acceptHeader: "accept: application/json"},
        method: (method?.toUpperCase()));
    var response;
    try {
      if (method?.toLowerCase() == "post") {
        response = await _client.post(url,
            data: FormData.fromMap(data),
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress);
      } else {
        options = buildCacheOptions(Duration(days: 7), options: options);
        response = await _client.get(url,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress);
      }
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        failCallBack(-999, "cancel");
      }
      return Future.value();
    } catch (e) {
      if (await isConnected()) {
        failCallBack(-998, "error request ");
      } else {
        failCallBack(-997, "no net work");
      }
      return Future.value();
    }
    print("====response.toString()=======${response.toString()}");
    var result = response?.data;
    print("====result=======$result");
    if (!result["error"]) {
      callBack(result);
    } else {
      failCallBack(-996, result["msg"]);
    }
  }

  void dioDown(
    String url,
    var localPath,
    onReceiveProgress(int count, int total), {
    dynamic data,
    var queryParameters,
    CancelToken cancelToken,
    onSendProgress(int count, int total),
    failCallBack(int code, String msg),
  }) async {
    Options options = new Options();
    try {
      await _client.download(
        url,
        localPath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        data: data,
        options: options,
      );
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        if (failCallBack != null) {
          failCallBack(-999, "cancel");
        }
      }
      return Future.value();
    } catch (exception) {
      if (await isConnected()) {
        failCallBack(-998, "error request ");
      } else {
        failCallBack(-997, "no net work");
      }
      return Future.value();
    }
  }
}
