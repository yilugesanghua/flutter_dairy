import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dairy/flutter_redux_store/redux_state.dart';
import 'package:flutter_dairy/ui/create/dairy_reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CreateDairyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateDairyState();
  }
}

class CreateDairyState extends State<CreateDairyPage> {
  bool _offstage = true;
  double _sendOpacity = 0.5;
  final titleControl = TextEditingController();
  final contentTextFieldNode = FocusNode();
  String _title, _content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.blueAccent,
            leading: Icon(
              Icons.close,
              color: Colors.white,
            ),
            title: Text(
              "新建日记",
              style: TextStyle(color: Colors.white, fontSize: 15),
              maxLines: 1,
            ),
            centerTitle: true,
            actions: <Widget>[
              StoreConnector<ReduceState, VoidCallback>(
                converter: (store) {
                  return () {
                    print("************************");
                    if (_sendOpacity == 1) {
                      store.dispatch(toCreateDairy(context,
                          weather: _title, content: _content, mood: "开心"));
                    }
                  };
                },
                builder: (BuildContext context, callback) {
                  return Opacity(
                    opacity: _sendOpacity,
                    child: GestureDetector(
                      onTap: callback,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(right: 12),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: titleControl,
                  onEditingComplete: () {
                    print(
                        "=========================onEditingComplete===========================");
                    FocusScope.of(context).requestFocus(contentTextFieldNode);
                  },
                  onChanged: (value) {
                    _title = value;
                    setState(() {
                      _sendOpacity =
                          (_title.isEmpty || _content.isEmpty) ? 0.5 : 1;
                      _offstage = (value == null || value.length == 0);
                    });
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "请输入标题",
                    labelText: "标题 :  ",
                    labelStyle: TextStyle(color: Colors.black87, fontSize: 15),
                    hintStyle: TextStyle(color: Colors.black26, fontSize: 13),
//                        prefix: Text("标题:  ",style:   TextStyle(color: Colors.black87, fontSize: 14),),
//                        prefixText: "标题:  ",
//                        prefixStyle:
//                            TextStyle(color: Colors.black87, fontSize: 14),
                    contentPadding: EdgeInsets.all(
                      8,
                    ),
                    suffixIcon: Offstage(
                      offstage: _offstage,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Future.delayed(Duration(milliseconds: 50), () {
                              _title = "";
                              titleControl.clear();
                            });
                          });
                        },
                        child: Offstage(
                          offstage: false,
                          child: Icon(
                            Icons.cancel,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  child: TextField(
                    onChanged: (value) {
                      _content = value;
                      setState(() {
                        _sendOpacity =
                            (_title.isEmpty || _content.isEmpty) ? 0.5 : 1;
                      });
                    },
                    textInputAction: TextInputAction.search,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    focusNode: contentTextFieldNode,
                    decoration: InputDecoration(
                      labelText: "日记内容",
                      hintText: "请输入今天的日记内容~",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
