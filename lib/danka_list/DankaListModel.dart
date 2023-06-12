import 'package:flutter/material.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';
import 'package:shundoji_management_app/domein/danka.dart';

class DankaListModel extends ChangeNotifier {
  List<Danka>? dankaList;

  // int? dankaId;
  // String name = "";
  // String address = "";
  // int buppanFlg = 1;
  // String others = "";

  // Danka danka = Danka();

  // Future<List<Danka>> getDatabase() async {
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
}
