import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shundoji_management_app/add_danka/AddDankaPage.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';
import 'package:shundoji_management_app/danka_detail/DankaDetailPage.dart';
import 'package:page_transition/page_transition.dart';

import '../domein/danka.dart';
import '../edit_danka/EditDankaPage.dart';
import 'DankaListModel.dart';

class DankaListPage extends StatefulWidget {
  const DankaListPage({Key? key}) : super(key: key);

  @override
  _DankaListPageState createState() => _DankaListPageState();
}

class _DankaListPageState extends State<DankaListPage> {
  List<Danka>? dankaList;
  bool createSearchIndexListFlg = false;
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DankaListModel>(
      create: (_) => DankaListModel()..fetchDabkaList(),
      child: Scaffold(
        backgroundColor: Color(0xffFBFAF5),
        appBar: AppBar(
          flexibleSpace: Container(
              decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/appbar_bk.jpg'), fit: BoxFit.cover),
          )),
          title: _searchTextField(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 35),
              child: SizedBox(
                width: 40,
                child: DropdownButton(
                    isExpanded: true,
                    icon: Icon(Icons.sort),
                    underline: Container(),
                    items: const [
                      DropdownMenuItem(
                        child: Text('追加順'),
                        value: '追加順',
                      ),
                      DropdownMenuItem(
                        child: Text('名前順'),
                        value: '名前順',
                      )
                    ],
                    onChanged: (String? value) {
                      if ('追加順' == value) {
                        orderOfAddition();
                      } else if ('名前順' == value) {
                        orderOfName();
                      }
                    }),
              ),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Consumer<DankaListModel>(builder: (context, model, child) {
              if (model.dankaList == null) {
                return CircularProgressIndicator();
              } else {
                if (!createSearchIndexListFlg) {
                  dankaList = model.dankaList;
                }
              }

              final List<Widget> widgets = dankaList!
                  .map((danka) => Slidable(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 30, bottom: 10, left: 30),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 10, right: 15, bottom: 10, left: 15),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffEAE8E8)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Color(0xffFBFAF5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xff404040),
                                      offset: Offset(3, 3),
                                      blurRadius: 3),
                                  BoxShadow(
                                      color: Color(0xffffffff),
                                      offset: Offset(-3, -3),
                                      blurRadius: 3)
                                ]),
                            child: ListTile(
                              title: Text(
                                danka.name,
                                style: TextStyle(fontSize: 24),
                              ),
                              subtitle: Text(danka.address),
                              trailing: Icon(Icons.arrow_forward_ios_rounded),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(200))),
                              onTap: () async {
                                // 画面遷移
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    child:
                                        DankaDetailPage(danka.dankaId), //画面遷移先
                                    type: PageTransitionType
                                        .rightToLeft, //アニメーションの種類
                                  ),
                                );
                                model.fetchDabkaList();
                              },
                            ),
                          ),
                        ),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            // 削除ボタン
                            Container(
                              width: 185,
                              height: 85,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Color(0xffFBFAF5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xff404040),
                                        offset: Offset(3, 3),
                                        blurRadius: 3),
                                    BoxShadow(
                                        color: Color(0xffffffff),
                                        offset: Offset(-3, -3),
                                        blurRadius: 3)
                                  ]),
                              child: SlidableAction(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: '削除',
                                onPressed: (BuildContext) async {
                                  // 削除しますか？ポップ表示
                                  await showComfirmDialog(
                                      context, danka, model);
                                },
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList();
              dankaList = model.dankaList;
              createSearchIndexListFlg = false;
              return ListView(
                children: widgets,
              );
            }),
          ),
        ),
        floatingActionButton:
            Consumer<DankaListModel>(builder: (context, model, child) {
          return Column(
            verticalDirection: VerticalDirection.up,
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                heroTag: "addDanka",
                onPressed: () async {
                  // 画面遷移
                  final String? added = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddDankaPage(),
                      fullscreenDialog: true,
                    ),
                  );
                  model.fetchDabkaList();
                  if (added != null) {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('${added}さんを追加しました'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                tooltip: 'Increment',
                child: Icon(Icons.group_add),
                backgroundColor: Color(0xffFF5959),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: FloatingActionButton(
                    heroTag: "showMap",
                    child: Icon(Icons.map_outlined),
                    backgroundColor: Color(0xffD9A62E),
                    onPressed: (() async {
                      await mapDialog();
                    })),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _searchTextField() {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        icon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _controller.clear();
            });
          },
          icon: Icon(Icons.clear),
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.all(10),
      ),
      onChanged: (String searchWord) {
        setState(() {
          List<Danka> _searchIndexList = [];
          for (int i = 0; i < dankaList!.length; i++) {
            if (dankaList![i].name.contains(searchWord)) {
              _searchIndexList.add(dankaList![i]);
            }
          }
          dankaList = _searchIndexList;
          createSearchIndexListFlg = true;
        });
      },
    );
  }

  void orderOfName() {
    setState(() {
      dankaList!.sort(((a, b) => a.name.compareTo(b.name)));
    });
  }

  void orderOfAddition() {
    setState(() {
      dankaList!.sort(((a, b) => a.dankaId.compareTo(b.dankaId)));
    });
  }

  Future showComfirmDialog(
      BuildContext context, Danka danka, DankaListModel model) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("『${danka.name}』を削除しますか？"),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async {
                model.dankaDelete(danka.dankaId);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('${danka.name}を削除しました'),
                );
                model.fetchDabkaList();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }

  Future mapDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Image.asset('images/MapImage.png',
              height: 500, width: 350, fit: BoxFit.cover),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                child: Text("閉じる"),
                style: TextButton.styleFrom(
                    foregroundColor: Color(0xffAD1E6B),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    )),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        );
      },
    );
  }
}
