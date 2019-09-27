import 'package:connectivity/connectivity.dart';

Future<bool> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult != ConnectivityResult.none;
}

void getNetType() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
// 网络类型为移动网络
  } else if (connectivityResult == ConnectivityResult.wifi) {
// 网络类型为WIFI
  }
}
