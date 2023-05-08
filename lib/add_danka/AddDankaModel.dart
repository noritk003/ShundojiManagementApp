import 'package:flutter/material.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';

class AddDankaModel extends ChangeNotifier {
  String? name;
  String? address;
  bool buppanFlg = true;
  String? others;
  final databaseController = DatabaseController();

  Future addDanka() async {
    int convertedBuppanFlg = _ConvertBoolToInt(buppanFlg);
    await databaseController.insert(name, address, convertedBuppanFlg, others);
  }

// 最後に削除(デバッグ用で実装)
  Future inquery() async {
    await databaseController.query();
  }

  int _ConvertBoolToInt(pBool) {
    int rtnValue;
    if (pBool) {
      rtnValue = 1;
    } else {
      rtnValue = 0;
    }
    return rtnValue;
  }
}
