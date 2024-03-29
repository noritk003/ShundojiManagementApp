import 'package:flutter/material.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';

class EditDankaModel extends ChangeNotifier {

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

  Future updateDanka(danka) async {
    await databaseController.update(danka);
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
