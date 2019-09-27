import 'package:dio/dio.dart';
import 'package:flutter_dairy/http/api_service.dart';

getCategory({CancelToken cancelToken}) {
  APiService.instance.get(
      "http://gank.io/api/xiandu/categories",
      (result) {
        print("==APiService instance get==> $result");
      },
      cancelToken: cancelToken,
      failCallBack: (int code, String error) {
        print("==code==>$code,  error==> $error");
      });
}
