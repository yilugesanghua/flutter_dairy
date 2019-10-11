import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dairy/flutter_redux_store/redux_state.dart';
import 'package:flutter_dairy/ui/create/create_dairy_page.dart';
import 'package:flutter_dairy/ui/create/dairy.dart';
import 'package:flutter_dairy/ui/create/dairy_reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  final Store<ReduceState> store;

  HomePage(this.store);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.store.dispatch(dairyList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(
          "日记",
          style: TextStyle(color: Colors.white, fontSize: 15),
          maxLines: 1,
        ),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return CreateDairyPage();
              }));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 12),
          ),
        ],
      ),
      body: StoreConnector<ReduceState, List<Dairy>>(
        converter: (store) => store.state.dairyList,
        builder: (BuildContext context, List<Dairy> dairy) {
          return ListView.builder(
            padding: EdgeInsets.only(top: 16),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${dairy[index].weather} ${dairy[index].mood}",
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                      ),
                      Text(
                        "${dairy[index].content}",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "${formatDate(DateTime.fromMillisecondsSinceEpoch(dairy[index].time * 1000), [
                              yyyy,
                              '-',
                              mm,
                              '-',
                              dd,
                              ' ',
                              HH,
                              ':',
                              mm,
                            ])}",
                            style:
                                TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: dairy == null ? 0 : dairy.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        splashColor: Colors.pink,
        elevation: 2,
        onPressed: () {
          widget.store.dispatch(dairyList());
//          Navigator.of(context)
//              .push(MaterialPageRoute(builder: (BuildContext context) {
//            return CreateDairyPage();
//          }));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
