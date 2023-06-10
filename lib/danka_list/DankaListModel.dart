import 'package:flutter/material.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';
import 'package:shundoji_management_app/domein/danka.dart';

class DankaListModel extends ChangeNotifier {
  List<Danka>? dankaList;

  int? dankaId;
  String name = "";
  String address = "";
  int buppanFlg = 1;
  String others = "";

  Danka dank = Danka();

  // Future<List<Danka>> getDatabase() async {
  void fetchDabkaList() async {
    List<Map<String, dynamic>> dbAllRow = await DatabaseController().query();
    dankaList = dbAllRow.map((Map data) {
      dankaId = data['danka_id'];
      name = data['name'];
      address = data['address'];
      buppanFlg = data['buppanFlg'];
      others = data['others'];
      return Danka(dankaId!, name, address, buppanFlg, others);
    }).toList();
    notifyListeners();
  }
}
