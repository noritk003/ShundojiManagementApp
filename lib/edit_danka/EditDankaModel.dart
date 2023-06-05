import 'package:flutter/material.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';

class EditDankaModel extends ChangeNotifier {
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

  Future updateDanka() async {
    
    await databaseController.update(name, address, buppanFlg, others);
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

  bool ConvertIntToBool(pInt) {
    bool rtnValue;
    if (pInt == 1) {
      rtnValue = true;
    } else {
      rtnValue = false;
    }
    return rtnValue;
  }
}
