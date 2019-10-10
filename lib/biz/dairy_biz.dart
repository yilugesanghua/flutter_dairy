import 'package:dio/dio.dart';
import 'package:flutter_dairy/biz/dairy_api.dart';
import 'package:flutter_dairy/http/api_service.dart';

///登录接口
login (
  Function callBack, {
  CancelToken cancelToken,
  Map queryParameters,
  failCallBack(int code, String msg),
  onStart(),
}) async{
  APiService.instance.get(
    loginUrl,
    callBack,
    cancelToken: cancelToken,
    failCallBack: failCallBack,
    queryParameters: queryParameters,
    onStart: onStart,
  );
}
