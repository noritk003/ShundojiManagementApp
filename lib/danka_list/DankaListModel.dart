import 'package:flutter/material.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';
import 'package:shundoji_management_app/domein/danka.dart';

class DankaListModel extends ChangeNotifier {
  List<Danka>? dankaList;

  String dankaId = "";
  String name = "";
  String address = "";
  bool buppanFlg = true;
  String others = "";

  // Future<List<Danka>> getDatabase() async {
  void getDatabase() async {
    List<Map<String, dynamic>> dbAllRow = await DatabaseController().query();
    dankaList = dbAllRow.map((Map data) {
      dankaId = data['danka_id'];
      name = data['name'];
      address = data['address'];
      buppanFlg = data['buppanFlg'];
      others = data['others'];
      return Danka(dankaId, name, address, buppanFlg, others);
    }).toList();
    notifyListeners();
  }
}
