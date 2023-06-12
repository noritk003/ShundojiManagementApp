import 'package:flutter/material.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';
import 'package:shundoji_management_app/domein/danka.dart';

class AddDankaModel extends ChangeNotifier {
  // String? name;
  // String? address;
  // int buppanFlg = 1;
  // String? others;

  bool isLoading = false;

  final databaseController = DatabaseController();
  final danka = Danka();

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future addDanka() async {
    await databaseController.insert(danka);
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
