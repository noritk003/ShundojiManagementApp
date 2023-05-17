import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shundoji_management_app/add_danka/AddDankaPage.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';

import '../domein/danka.dart';
import 'DankaListModel.dart';

class DankaListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DankaListModel>(
      create: (_) => DankaListModel()..fetchDabkaList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('追加ページ'),
        ),
        body: Center(
          child: Consumer<DankaListModel>(builder: (context, model, child) {
            final List<Danka>? dankaList = model.dankaList;

            if (dankaList == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = dankaList
                .map((danka) => Slidable(
                      child: ListTile(
                        title: Text(danka.name),
                        subtitle: Text(danka.address),
                      ),
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          // 編集ボタン
                          // SlidableAction(
                          //   backgroundColor: Colors.black45,
                          //   foregroundColor: Colors.white,
                          //   icon: Icons.edit,
                          //   label: '編集',
                          //   onPressed: (BuildContext) async {
                          //     // 編集画面に遷移
                          //     final String? title = await Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => EditBookPage(book),
                          //       ),
                          //     );

                          //     if (title != null) {
                          //       final snackBar = SnackBar(
                          //         backgroundColor: Colors.green,
                          //         content: Text('$titleを編集しました'),
                          //       );
                          //       ScaffoldMessenger.of(context)
                          //           .showSnackBar(snackBar);
                          //     }
                          //     model.fetchBookList();
                          //   },
                          // ),

                          // 削除ボタン
                          SlidableAction(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: '削除',
                            onPressed: (BuildContext) async {
                              // 削除しますか？ポップ表示
                              await showComfirmDialog(context, danka, model);
                            },
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
        floatingActionButton:
            Consumer<DankaListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              // 画面遷移
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddDankaPage(),
                  fullscreenDialog: true,
                ),
              );

              if (added != null && added) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('本を追加しました'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              model.fetchDabkaList();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
            backgroundColor: Color(0xff009944),
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
                await DatabaseController().delete(danka);
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
