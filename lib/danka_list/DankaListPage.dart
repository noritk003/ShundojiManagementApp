import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shundoji_management_app/add_danka/AddDankaModel.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';
import 'package:shundoji_management_app/common_database/DatabaseHelper.dart';

import '../domein/danka.dart';
import 'DankaListModel.dart';


class DankaListPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DankaListModel>(
        create: (_) => DankaListModel(),
        child: Scaffold(
            appBar: AppBar(
              title: Text('追加ページ'),
            ),
            body: Center(
              child: Consumer<DankaListModel>(builder: (context, model, child) {
                final List<Danka>? dankaList = model.dankaList;

                if (dankaList == null) {
                  return CircularProgressIndicator();
                }

                final List<Widget> widgets = dankaList
                    .map(
                      (book) => Slidable(
                        child: ListTile(
                          title: Text(book.name),
                          subtitle: Text(book.address),
                        );

              }),
            )));
  }
}
