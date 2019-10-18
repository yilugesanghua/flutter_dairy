import 'dart:convert';

import 'package:flutter_dairy/biz/dairy_biz.dart';
import 'package:flutter_dairy/const/shareprefer_const.dart';
import 'package:flutter_dairy/flutter_redux_store/redux_state.dart';
import 'package:flutter_dairy/model/config.dart';
import 'package:flutter_dairy/util/sharepreference_util.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final configReducer = combineReducers<DiaryConfig>([
  TypedReducer<DiaryConfig, InitConfigAction>(_initConfig),
]);

class InitConfigAction {
  DiaryConfig diaryConfig;

  InitConfigAction({this.diaryConfig});
}

DiaryConfig _initConfig(DiaryConfig diaryConfig, InitConfigAction addAction) {
  print("======_createDairy=======>${addAction.diaryConfig}");
  print("======_createDairy  dairy: $diaryConfig=======>");
//  dairy = addAction.dairy;
  diaryConfig = addAction.diaryConfig;
  print("======_createDairy  dairy: $diaryConfig=======>");
  return diaryConfig;
}

///获取日记配置
ThunkAction<ReduceState> dairyInitConfig() {
  return (Store<ReduceState> store) async {
    await getConfig(
      (result) async {
        print("getConfig result -> $result");
        store.dispatch(
            InitConfigAction(diaryConfig: DiaryConfig.fromJson(result)));
        var configJson = json.encode(result);
        await SharePreferenceUtil.getInstance()
            .putStringValue(CONFIG, configJson);
        print("getConfig result save-> $configJson");
      },
      failCallBack: (int code, String msg) async {
        print("getConfig fail :  code is : $code ,msg is : $msg");
        String configJson =
            await SharePreferenceUtil.getInstance().getStringValue(CONFIG);
        if (configJson == "") {
          configJson = """
          {"result":{"weathers":[{"id":1,"weather":"晴","iconUrl":null},{"id":2,"weather":"多云","iconUrl":null},{"id":3,"weather":"阴","iconUrl":null}],"moods":[{"id":1,"mood":"开心","iconUrl":null},{"id":2,"mood":"快乐","iconUrl":null}]}}
          """;
        }
        if (configJson != null && configJson.isNotEmpty) {
          var config = json.decode(configJson);
          print("getConfig result get-> $configJson");
          store.dispatch(InitConfigAction(diaryConfig: DiaryConfig.fromJson(config)));
        }
      },
      onStart: () {
        print("getConfig onStart :");
      },
    );
  };
}
