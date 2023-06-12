import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shundoji_management_app/add_danka/AddDankaModel.dart';
import 'package:shundoji_management_app/common_database/DatabaseController.dart';
import 'package:shundoji_management_app/common_database/DatabaseHelper.dart';
import 'package:shundoji_management_app/domein/danka.dart';

import 'EditDankaModel.dart';

class EditDankaPage extends StatefulWidget {
  // const EditDankaPage({super.key});

  EditDankaPage(this.danka);

  Danka danka;

  @override
  State<EditDankaPage> createState() => _EditDankaPageState(danka);
}

class _EditDankaPageState extends State<EditDankaPage> {
  bool buppanState = true;

  _EditDankaPageState(this.danka);

  Danka danka;

  // DatabaseHelper クラスのインスタンス取得
  final databaseHelper = DatabaseHelper.instance;
  final databaseController = DatabaseController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditDankaModel>(
        create: (_) => EditDankaModel(),
        child: Scaffold(
            backgroundColor: Color(0xffFBFAF5),
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              flexibleSpace: Container(
                  decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/appbar_bk.jpg'),
                    fit: BoxFit.cover),
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
            body: Center(
              child: Consumer<EditDankaModel>(builder: (context, model, child) {
                return Stack(children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 12),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffFBFAF5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xffB3B3B3),
                                        offset: Offset(-1, -1)),
                                    BoxShadow(
                                        color: Color(0xffffffff),
                                        offset: Offset(1, 1))
                                  ]),
                              child: SizedBox(
                                  width: 60,
                                  height: 30,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          '名前',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 35,
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: '名前',
                                    hintStyle: TextStyle(fontSize: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: Color(0xffD9D9D9))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: Color(0xffD9D9D9))),
                                  ),
                                  controller:
                                      TextEditingController(text: danka.name),
                                  onChanged: (text) {
                                    model.name = text;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffFBFAF5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xffB3B3B3),
                                        offset: Offset(-1, -1)),
                                    BoxShadow(
                                        color: Color(0xffffffff),
                                        offset: Offset(1, 1))
                                  ]),
                              child: SizedBox(
                                  width: 60,
                                  height: 30,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          '地域',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 35,
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: '地域',
                                    hintStyle: TextStyle(fontSize: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: Color(0xffD9D9D9))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: Color(0xffD9D9D9))),
                                  ),
                                  controller: TextEditingController(
                                      text: danka.address),
                                  onChanged: (text) {
                                    model.address = text;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xffFBFAF5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xffB3B3B3),
                                      offset: Offset(-1, -1)),
                                  BoxShadow(
                                      color: Color(0xffffffff),
                                      offset: Offset(1, 1))
                                ]),
                            child: SizedBox(
                                width: 60,
                                height: 30,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        '仏飯',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CupertinoSwitch(
                            value: model.ConvertIntToBool(danka.buppanFlg),
                            onChanged: (value) {
                              setState(() => buppanState = value);
                              danka.buppanFlg =
                                  model.ConvertBoolToInt(buppanState);
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffFBFAF5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xffB3B3B3),
                                        offset: Offset(-1, -1)),
                                    BoxShadow(
                                        color: Color(0xffffffff),
                                        offset: Offset(1, 1))
                                  ]),
                              child: SizedBox(
                                  width: 60,
                                  height: 30,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          'その他',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 10,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: 'その他',
                                  hintStyle: TextStyle(fontSize: 12),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Color(0xffD9D9D9))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Color(0xffD9D9D9))),
                                ),
                                controller:
                                    TextEditingController(text: danka.others),
                                onChanged: (text) {
                                  model.others = text;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 75,
                        height: 30,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff404040),
                                    offset: Offset(1, 1),
                                    blurRadius: 3),
                                BoxShadow(
                                    color: Color(0xffffffff),
                                    offset: Offset(-1, -1),
                                    blurRadius: 3)
                              ]),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Color(0xffFBFAF5),
                                  foregroundColor: Color(0xffffaebd7),
                                  elevation: 0,
                                  shadowColor: Color(0xff404040)),
                              child: Text(
                                '更新',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff000000)),
                              ),
                              onPressed: () async {
                                try {
                                  model.startLoading();
                                  await model.updateDanka(danka);
                                  Navigator.of(context).pop(model.name);
                                } catch (e) {
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(e.toString()),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } finally {
                                  model.endLoading();
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ]);
              }),
            )));
  }
}
