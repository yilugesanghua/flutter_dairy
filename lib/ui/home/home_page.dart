import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dairy/flutter_redux_store/redux_state.dart';
import 'package:flutter_dairy/ui/create/create_dairy_page.dart';
import 'package:flutter_dairy/ui/create/dairy.dart';
import 'package:flutter_dairy/ui/create/dairy_reducer.dart';
import 'package:flutter_dairy/ui/home/diary_detail.dart';
import 'package:flutter_dairy/util/screen_size.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  int page = 1;
  EasyRefreshController _controller = EasyRefreshController();

  @override
  void initState() {
    super.initState();
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
          return EasyRefresh(
            emptyWidget: dairy==null||dairy.isEmpty?Icon(Icons.sort,color: Colors.red,):null,
            firstRefresh: true,
            enableControlFinishLoad: true,
            enableControlFinishRefresh: true,
            controller: _controller,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 16),
              itemBuilder: (BuildContext context, int index) {
                final item = dairy[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return DiaryDetailPage(item);
                    }));
                  },
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.2,
                    secondaryActions: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: px16),
                        child: IconSlideAction(
                          caption: 'Archive2',
                          color: Colors.blue,
                          icon: Icons.archive,
                          onTap: () => widget.store
                              .dispatch(DeleteDairyAction(dairy: item)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: px16),
                        child: IconSlideAction(
                          caption: 'Share2',
                          color: Colors.indigo,
                          icon: Icons.share,
                          onTap: () => widget.store
                              .dispatch(DeleteDairyAction(dairy: item)),
                        ),
                      )
                    ],
                    child: Card(
                      margin: EdgeInsets.only(
                          left: px16, right: px16, bottom: px16),
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
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 6),
                            ),
                            Hero(
                                transitionOnUserGestures: true,
                                tag: "detail${item.id}",
                                child: Text(
                                  "${dairy[index].content}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                )),
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
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: dairy == null ? 0 : dairy.length,
            ),
            onRefresh: () async {
              page = 1;
              widget.store.dispatch(await dairyList(_controller, page: page,
                  success: (List<Dairy> result, int pageSize) {
                page++;
              }));
            },
            onLoad: () async {
              widget.store.dispatch(await dairyList(_controller, page: page,
                  success: (List<Dairy> result, int pageSize) {
                page++;
              }));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        splashColor: Colors.pink,
        elevation: 2,
        onPressed: () {
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
    );
  }
}
