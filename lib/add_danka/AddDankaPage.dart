import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shundoji_management_app/add_danka/AddDankaModel.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';
import 'package:shundoji_management_app/common_database/DatabaseHelper.dart';

class AddDankaPage extends StatefulWidget {
  const AddDankaPage({super.key});

  @override
  State<AddDankaPage> createState() => _AddDankaPageState();
}

class _AddDankaPageState extends State<AddDankaPage> {
  bool buppanState = true;

  // DatabaseHelper クラスのインスタンス取得
  final databaseHelper = DatabaseHelper.instance;
  final databaseController = DatabaseController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddDankaModel>(
        create: (_) => AddDankaModel(),
        child: Scaffold(
            appBar: AppBar(
              title: Text('追加ページ'),
            ),
            body: Center(
              child: Consumer<AddDankaModel>(builder: (context, model, child) {
                return Stack(children: [
                  Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: '氏名',
                        ),
                        onChanged: (text) {
                          model.name = text;
                        },
                      ),
                      CupertinoSwitch(
                        value: buppanState,
                        onChanged: (value) {
                          setState(() => buppanState = value);
                          model.buppanFlg = buppanState;
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '地域',
                        ),
                        onChanged: (text) {
                          model.address = text;
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'その他',
                        ),
                        onChanged: (text) {
                          model.others = text;
                        },
                      ),
                      ElevatedButton(
                          child: Text(
                            '登録',
                            style: TextStyle(fontSize: 35),
                          ),
                          onPressed: () async {
                            model.addDanka();
                          }),

                      // 最後に削除(デバッグ用で実装)
                      ElevatedButton(
                          child: Text(
                            '照会',
                            style: TextStyle(fontSize: 35),
                          ),
                          onPressed: () async {
                            model.inquery();
                          }),
                    ],
                  ),
                ]);
              }),
            )));
  }

  // // 登録ボタンクリック
  // void _insert() async {
  //   // row to insert
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnName : '山田　太郎',
  //     DatabaseHelper.columnAge  : 35
  //   };
  //   final id = await dbHelper.insert(row);
  //   print('登録しました。id: $id');
  // }

  // // 照会ボタンクリック
  // void _query() async {
  //   final allRows = await dbHelper.queryAllRows();
  //   print('全てのデータを照会しました。');
  //   allRows.forEach(print);
  // }

  // // 更新ボタンクリック
  // void _update() async {
  //    Map<String, dynamic> row = {
  //     DatabaseHelper.columnId   : 1,
  //     DatabaseHelper.columnName : '鈴木　一郎',
  //     DatabaseHelper.columnAge  : 48
  //   };
  //   final rowsAffected = await dbHelper.update(row);
  //   print('更新しました。 ID：$rowsAffected ');
  // }

  // // 削除ボタンクリック
  // void _delete() async {
  //   final id = await dbHelper.queryRowCount();
  //   final rowsDeleted = await dbHelper.delete(id!);
  //   print('削除しました。 $rowsDeleted ID: $id');
  // }
}
