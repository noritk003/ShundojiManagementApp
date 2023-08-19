import 'package:shundoji_management_app/domein/danka.dart';

import 'DatabaseHelper.dart';

class DatabaseController {
  final databaseHelper = DatabaseHelper.instance;

  // レコード追加
  Future insert(data) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: data.name,
      DatabaseHelper.columnAddress: data.address,
      DatabaseHelper.columnBuppanFlg: data.buppanFlg,
      DatabaseHelper.columnOthers: data.others
    };
    final id = await databaseHelper.insert(row);
    print('登録しました。id: $id');
  }

  // データ照会
  Future query() async {
    final allRows = await databaseHelper.queryAllRows();
    print('全てのデータを照会しました。');
    allRows.forEach(print);
    return allRows;
  }

  // データ照会(ID指定)
  Future querySelectedId(id) async {
    final selectedIdData = await databaseHelper.querySelectedId(id);
    return selectedIdData;
  }

  // データ全件更新
  Future update(data) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: data.dankaId,
      DatabaseHelper.columnName: data.name,
      DatabaseHelper.columnAddress: data.address,
      DatabaseHelper.columnBuppanFlg: data.buppanFlg,
      DatabaseHelper.columnOthers: data.others
    };
    final rowsAffected = await databaseHelper.update(row);
    print('更新しました。 ID：$rowsAffected ');
  }

  // データ削除
  Future delete(id) async {
    final rowsDeleted = await databaseHelper.delete(id);
    print('削除しました。 $rowsDeleted ID: $id');
  }
}
