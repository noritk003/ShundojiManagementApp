import 'DatabaseHelper.dart';

class DatabaseController {
  final databaseHelper = DatabaseHelper.instance;

  // レコード追加
  Future insert(name, address, buppanFlg, others) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnAddress: address,
      DatabaseHelper.columnBuppanFlg: buppanFlg,
      DatabaseHelper.columnOthers: others
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

  // データ更新
  Future update(name, address, buppanFlg, others) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: 1,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnAddress: address,
      DatabaseHelper.columnBuppanFlg: buppanFlg,
      DatabaseHelper.columnOthers: others
    };
    final rowsAffected = await databaseHelper.update(row);
    print('更新しました。 ID：$rowsAffected ');
  }

  // データ削除
  Future delete(data) async {
    final id = await databaseHelper.queryRowCount();
    final rowsDeleted = await databaseHelper.delete(id!);
    print('削除しました。 $rowsDeleted ID: $id');
  }
}
