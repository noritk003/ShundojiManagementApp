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

class DankaListPage extends StatelessWidget {
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
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Consumer<DankaListModel>(builder: (context, model, child) {
              final List<Danka>? dankaList = model.dankaList;

              if (dankaList == null) {
                return CircularProgressIndicator();
              }

              final List<Widget> widgets = dankaList
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
                                  // border: Border.all(color: Color(0xffEAE8E8)),
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
                                  model.dankaDelete(danka.dankaId);
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
              return ListView(
                children: widgets,
              );
            }),
          ),
        ),
        floatingActionButton:
            Consumer<DankaListModel>(builder: (context, model, child) {
          return FloatingActionButton(
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
          );
        }),
      ),
    );
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
                await DatabaseController().delete(danka.dankaId);
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
}
