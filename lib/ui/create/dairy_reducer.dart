import 'package:flutter/cupertino.dart';
import 'package:flutter_dairy/biz/dairy_biz.dart';
import 'package:flutter_dairy/flutter_redux_store/redux_state.dart';
import 'package:flutter_dairy/model/dairy.dart';
import 'package:flutter_dairy/util/toast_util.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final dairyReducer = combineReducers<List<Dairy>>([
  TypedReducer<List<Dairy>, CreateDairyAction>(_createDairy),
  TypedReducer<List<Dairy>, RefreshListAction>(_refreshList),
  TypedReducer<List<Dairy>, LoadListAction>(_loadList),
  TypedReducer<List<Dairy>, EditDairyAction>(_editDairy),
  TypedReducer<List<Dairy>, DeleteDairyAction>(_deleteDairy),
]);

///创建
class CreateDairyAction {
  Dairy dairy;

  CreateDairyAction({this.dairy});
}

List<Dairy> _createDairy(List<Dairy> dairy, CreateDairyAction addAction) {
  print("======_createDairy=======>${addAction.dairy}");
  print("======_createDairy  dairy: $dairy=======>");
//  dairy = addAction.dairy;
  dairy.insert(0, addAction.dairy);
  print("======_createDairy  dairy: $dairy=======>");
  return dairy;
}

///编辑
class EditDairyAction {
  Dairy dairy;

  EditDairyAction({this.dairy});
}

List<Dairy> _editDairy(List<Dairy> dairy, EditDairyAction addAction) {
  print("======_login=======>${addAction.dairy}");
  for (int i = 0; i < dairy.length; i++) {
    if (addAction.dairy.id == dairy[i].id) {
      dairy[i] = addAction.dairy;
      break;
    }
  }
  return dairy;
}

///删除
class DeleteDairyAction {
  Dairy dairy;

  DeleteDairyAction({this.dairy});
}

List<Dairy> _deleteDairy(List<Dairy> dairy, DeleteDairyAction addAction) {
  print("======_login=======>${addAction.dairy}");
  dairy?.remove(addAction.dairy);
  return dairy;
}

//刷新列表
class RefreshListAction {
  List<Dairy> dairyList;

  RefreshListAction({this.dairyList});
}

List<Dairy> _refreshList(List<Dairy> dairy, RefreshListAction action) {
  print("====>dairy  ${dairy.length}");
  dairy.clear();
  print("====>action  ${action.dairyList.length}");
  dairy.addAll(action.dairyList ?? List());
  print("====>dairy  ${dairy.length}");
  return dairy;
}

//加载更多列表
class LoadListAction {
  List<Dairy> dairyList;

  LoadListAction({this.dairyList});
}

List<Dairy> _loadList(List<Dairy> dairy, LoadListAction action) {
  dairy.addAll(action.dairyList ?? List());
  return dairy;
}

///获取日记列表数据
Future<ThunkAction<ReduceState>> dairyList(EasyRefreshController _controller,
    {int page = 1, int pageCount = 20, success, failCallback}) async {
  return (Store<ReduceState> store) async {
    Map<String, String> params = Map();
    params["page"] = "$page";
    params["pageCount"] = "$pageCount";
    await getDairyList(
        (result) {
          print("getDairyList==> $result");
          List<Dairy> list = Dairy.fromMapList(result);

          if (page == 1) {
            print("====onRefresh page =1===");
            _controller.resetLoadState();
            _controller.finishRefresh();
            store.dispatch(RefreshListAction(dairyList: list));
          } else {
            print("====onRefresh page !=1===");
            _controller.finishLoad(
                noMore: (list == null || list.length < pageCount));
            store.dispatch(LoadListAction(dairyList: list));
          }
          if (success != null) {
            success(list ?? List<Dairy>(), pageCount);
          }
        },
        queryParameters: params,
        failCallBack: failCallback,
        onStart: () {
          print("getDairyList==> onstart");
        });
  };
}

///创建日记
ThunkAction<ReduceState> toCreateDairy(BuildContext context,
    {String weather, String content, String moodId,String weatherId}) {
  return (Store<ReduceState> store) async {
    Map<String, String> params = Map();
    params["weather"] = weather;
    params["content"] = content;
    params["moodId"] = moodId;
    params["weatherId"] = weatherId;
    createDairy(
        (result) {
          print("创建成功 result : $result");
          KingToast.show("创建成功", gravity: ToastGravity.CENTER);
          Dairy dairy = Dairy.fromJson(result);
          store.dispatch(CreateDairyAction(dairy: dairy));
          Navigator.of(context).pop();
        },
        data: params,
        failCallBack: (code, msg) {
          print("===toCreateDairy fail  code is : $code   msg is :$msg=====");
        },
        onStart: () {
          print("===开始创建=====");
        });
  };
}
