import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dairy/flutter_redux_store/redux_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CreateDairyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateDairyState();
  }
}

class CreateDairyState extends State<CreateDairyPage> {
  bool _offstage = true;
  final titleControl = TextEditingController();
  final contentTextFieldNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
      builder: (BuildContext context, Store<ReduceState> store) {
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
                  Opacity(
                    opacity: 0.5,
                    child: GestureDetector(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
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
                      controller: titleControl,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(contentTextFieldNode);
                      },
                      onChanged: (value) {
                        setState(() {
                          _offstage = (value == null || value.length == 0);
                        });
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "请输入标题",
                        labelText: "标题 :  ",
                        labelStyle:
                            TextStyle(color: Colors.black87, fontSize: 15),
                        hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 13),
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
                                titleControl.text="";
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
                        textInputAction: TextInputAction.done,
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
      },
    );
  }
}
