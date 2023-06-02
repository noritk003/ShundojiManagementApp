import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shundoji_management_app/add_danka/AddDankaModel.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';
import 'package:shundoji_management_app/common_database/DatabaseHelper.dart';

import '../domein/danka.dart';

class DankaDetailPage extends StatelessWidget {
  DankaDetailPage(this.danka);

  Danka danka;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFBFAF5),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          flexibleSpace: Container(
              decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/appbar_bk.jpg'), fit: BoxFit.cover),
          )),
          actions: [
            Icon(
              Icons.save,
              color: Colors.black,
              size: 30,
            ),
            SizedBox(
              width: 40,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50, right: 40, left: 40),
          child: Column(
            children: [
              Text(
                '名前',
                style: TextStyle(fontSize: 12, color: Color(0xffAD1E6B)),
              ),
              Text(
                danka.name,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '地域',
                style: TextStyle(fontSize: 12, color: Color(0xffAD1E6B)),
              ),
              Text(
                danka.address,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '仏飯',
                style: TextStyle(fontSize: 12, color: Color(0xffAD1E6B)),
              ),
              Text(
                'あり',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'その他',
                style: TextStyle(fontSize: 12, color: Color(0xffAD1E6B)),
              ),
              Text(
                danka.others,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
