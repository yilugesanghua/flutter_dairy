import 'package:dio/dio.dart';
import 'package:flutter_dairy/biz/dairy_api.dart';
import 'package:flutter_dairy/http/api_service.dart';

///登录接口
login(
  Function callBack, {
  CancelToken cancelToken,
  Map<String, String> data,
  failCallBack(int code, String msg),
  onStart(),
}) async {
  APiService.instance.post(
    loginUrl,
    callBack,
    cancelToken: cancelToken,
    failCallBack: failCallBack,
    data: data,
    onStart: onStart,
  );
}

///创建日记
createDairy(
  Function callBack, {
  CancelToken cancelToken,
  Map<String, String> data,
  Map headers,
  failCallBack(int code, String msg),
  onStart(),
}) async {
  APiService.instance.post(
    createDairyUrl,
    callBack,
    cancelToken: cancelToken,
    failCallBack: failCallBack,
    data: data,
    headers: headers,
    onStart: onStart,
  );
}

///日记列表
getDairyList(
  Function callBack, {
  CancelToken cancelToken,
  Map<String, String> queryParameters,
  Map headers,
  failCallBack(int code, String msg),
  onStart(),
}) async {
  APiService.instance.get(
    dairyListUrl,
    callBack,
    cancelToken: cancelToken,
    failCallBack: failCallBack,
    queryParameters: queryParameters,
    headers: headers,
    onStart: onStart,
  );
}

///获取配置信息
getConfig(
  Function callBack, {
  CancelToken cancelToken,
  Map<String, String> queryParameters,
  Map headers,
  failCallBack(int code, String msg),
  onStart(),
}) async {
  APiService.instance.get(configUrl, callBack,
      cancelToken: cancelToken,
      failCallBack: failCallBack,
      queryParameters: queryParameters,
      headers: headers,
      onStart: onStart,
      maxAge: Duration(days: 7));
}
