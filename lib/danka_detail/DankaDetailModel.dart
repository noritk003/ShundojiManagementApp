import 'package:flutter/material.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';
import 'package:shundoji_management_app/domein/danka.dart';

class DankaDetailModel extends ChangeNotifier {
  // late List<Map<String, dynamic>> dankaList;
  List<Danka>? dankaList;

  Future getSelectedData(selectedId) async {
    List<Map<String, dynamic>> selectedData =
        await DatabaseController().querySelectedId(selectedId);
    // dankaList = selectedData;
    // return selectedData;

    dankaList = selectedData.map((Map data) {
      Danka danka = Danka();
      danka.dankaId = data['danka_id'];
      danka.name = data['name'];
      danka.address = data['address'];
      danka.buppanFlg = data['buppanFlg'];
      danka.others = data['others'];
      return danka;
    }).toList();
    notifyListeners();

    return dankaList;
  }
}