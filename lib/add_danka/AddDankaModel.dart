import 'package:flutter/material.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';

class AddDankaModel extends ChangeNotifier {
  String? name;
  String? address;
  int buppanFlg = 1;
  String? others;

  bool isLoading = false;

  final databaseController = DatabaseController();

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future addDanka() async {
    await databaseController.insert(name, address, buppanFlg, others);
  }

// 最後に削除(デバッグ用で実装)
  Future inquery() async {
    await databaseController.query();
  }

  int ConvertBoolToInt(pBool) {
    int rtnValue;
    if (pBool) {
      rtnValue = 1;
    } else {
      rtnValue = 0;
    }
    return rtnValue;
  }
}
