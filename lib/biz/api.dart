import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dairy/http/api_service.dart';
import 'package:flutter_dairy/util/file_util.dart';
import 'package:path_provider/path_provider.dart';

getCategory({CancelToken cancelToken}) async {
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

//https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4
downLoadTest({
  onReceiveProgress(int count, int total),
  bool continued = true,
  int startPoint = 0,
  Map queryParameters,
  CancelToken cancelToken,
  failCallBack(int code, String msg),
}) async {
  String documentsDir = await getDownloadPath();
  if (documentsDir != null) {
    File file = new File("$documentsDir" + "a.jpg");
    //http://img0.imgtn.bdimg.com/it/u=2786741331,312930537&fm=26&gp=0.jpg
    APiService.instance.down(
        "https://www.baidu.com/img/xinshouyedong_4f93b2577f07c164ae8efa0412dd6808.gif",
        file.path, (int count, int total) {
      print("下载进度 ===curCount :$count  total: $total");
      if (count == total) {
        print("下载成功");
      }
    }, failCallBack: (int code, String message) {
      print("下载失败 ===code :$code  message: $message");
    });
  }
}
