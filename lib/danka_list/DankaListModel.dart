import 'package:flutter/material.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';
import 'package:shundoji_management_app/domein/danka.dart';

class DankaListModel extends ChangeNotifier {
  List<Danka>? dankaList;

  void fetchDabkaList() async {
    List<Map<String, dynamic>> dbAllRow = await DatabaseController().query();
    dankaList = dbAllRow.map((Map data) {
      Danka danka = Danka();
      danka.dankaId = data['danka_id'];
      danka.name = data['name'];
      danka.address = data['address'];
      danka.buppanFlg = data['buppanFlg'];
      danka.others = data['others'];
      return danka;
    }).toList();
    notifyListeners();
  }

  void dankaDelete(dankaId) async {
    await DatabaseController().delete(dankaId);
  }
}
