import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shundoji_management_app/add_danka/AddDankaModel.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';
import 'package:shundoji_management_app/common_database/DatabaseHelper.dart';
import 'package:shundoji_management_app/danka_detail/DankaDetailModel.dart';
import 'package:shundoji_management_app/danka_list/DankaListModel.dart';
import 'package:shundoji_management_app/edit_danka/EditDankaPage.dart';

import '../domein/danka.dart';

class DankaDetailPage extends StatelessWidget {
  DankaDetailPage(this.dankaId);

  int dankaId;
  Danka danka = Danka();
  DankaDetailModel fmodel = DankaDetailModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DankaDetailModel>(
      create: (_) => DankaDetailModel()..getSelectedData(dankaId),
      child: Scaffold(
        backgroundColor: Color(0xffFBFAF5),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          flexibleSpace: Container(
              decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/appbar_bk.jpg'), fit: BoxFit.cover),
          )),
          actions: [
            Consumer<DankaDetailModel>(builder: (context, model, child) {
              final Widget widgets = IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.black,
                  iconSize: 30,
                  onPressed: () async {
                    // final result = await Navigator.push(
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditDankaPage(danka),
                        // fullscreenDialog: true,
                      ),
                    );
                    // DankaDetailModel().getSelectedData(dankaId);
                    // final model = context.read();
                    // model.reload();
                    model.getSelectedData(dankaId);
                  });
              return widgets;
            }),
            SizedBox(
              width: 40,
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Consumer<DankaDetailModel>(builder: (context, model, child) {
              // final List<Danka>? dankaList = model.dankaList;
              danka = model.danka;

              if (danka == null) {
                return CircularProgressIndicator();
              }
              final Widget widgets = Padding(
                padding: const EdgeInsets.only(top: 50, right: 40, left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.black,
                        iconSize: 30,
                        onPressed: () async {
                          // final result = await Navigator.push(
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditDankaPage(danka),
                              // fullscreenDialog: true,
                            ),
                          );
                          DankaDetailModel().getSelectedData(dankaId);
                          // model.getSelectedData(dankaId);
                          // final model = context.read();
                          // model.reload();
                        }),
                    Text(
                      '名前',
                      style: TextStyle(fontSize: 12, color: Color(0xffAD1E6B)),
                    ),
                    Text(
                      model.danka.name,
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
                      model.danka.address,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      '仏飯',
                      style: TextStyle(fontSize: 12, color: Color(0xffAD1E6B)),
                    ),
                    buppanFlgPresence(model.danka.buppanFlg),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'その他',
                      style: TextStyle(fontSize: 12, color: Color(0xffAD1E6B)),
                    ),
                    Text(
                      model.danka.others,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              );

              return widgets;
            }),
          ),
        ),
      ),
    );
  }

  Widget buppanFlgPresence(int buppanflg) {
    if (buppanflg == 1) {
      return Text(
        'あり',
        style: TextStyle(fontSize: 16),
      );
    } else {
      return Text(
        'なし',
        style: TextStyle(fontSize: 16),
      );
    }
  }
}
