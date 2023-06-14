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
  DankaDetailPage(this.dankaId) {
    // 型変換うまくいかない
    dankaData = DankaDetailModel().getSelectedData(dankaId) as List<Danka>;
    danka = dankaData[0];
  }

  int dankaId;
  late List<Danka> dankaData;
  late Danka danka;

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
            IconButton(
                icon: Icon(Icons.edit),
                color: Colors.black,
                iconSize: 30,
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditDankaPage(danka),
                      fullscreenDialog: true,
                    ),
                  );
                }),
            SizedBox(
              width: 40,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50, right: 40, left: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              buppanFlgPresence(danka.buppanFlg),
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

// class DankaDetailPage extends StatefulWidget {
//   const DankaDetailPage({super.key});

//   @override
//   State<DankaDetailPage> createState() => _DankaDetailPageState();
// }

// class _DankaDetailPageState extends State<DankaDetailPage> {
//   bool buppanState = true;

//   // DatabaseHelper クラスのインスタンス取得
//   final databaseHelper = DatabaseHelper.instance;
//   final databaseController = DatabaseController();

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<DankaDetailModel>(
//         create: (_) => DankaDetailModel(),
//         child: Scaffold(
//             backgroundColor: Color(0xffFBFAF5),
//             appBar: AppBar(
//               iconTheme: IconThemeData(color: Colors.black),
//               flexibleSpace: Container(
//                   decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage('images/appbar_bk.jpg'),
//                     fit: BoxFit.cover),
//               )),
//               actions: [
//                 Icon(
//                   Icons.save,
//                   color: Colors.black,
//                   size: 30,
//                 ),
//                 SizedBox(
//                   width: 40,
//                 )
//               ],
//             ),
//             body: Center(
//               child: Consumer<AddDankaModel>(builder: (context, model, child) {
//                 return Stack(children: [
//                   Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 50, bottom: 12),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: 40,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Color(0xffFBFAF5),
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(7)),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Color(0xffB3B3B3),
//                                         offset: Offset(-1, -1)),
//                                     BoxShadow(
//                                         color: Color(0xffffffff),
//                                         offset: Offset(1, 1))
//                                   ]),
//                               child: SizedBox(
//                                   width: 60,
//                                   height: 30,
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         child: Text(
//                                           '名前',
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                               child: SizedBox(
//                                 height: 35,
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                     contentPadding: EdgeInsets.all(10),
//                                     hintText: '名前',
//                                     hintStyle: TextStyle(fontSize: 12),
//                                     enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0)),
//                                         borderSide: BorderSide(
//                                             color: Color(0xffD9D9D9))),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0)),
//                                         borderSide: BorderSide(
//                                             color: Color(0xffD9D9D9))),
//                                   ),
//                                   onChanged: (text) {
//                                     model.danka.name = text;
//                                   },
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 40,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 12, bottom: 12),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: 40,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Color(0xffFBFAF5),
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(7)),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Color(0xffB3B3B3),
//                                         offset: Offset(-1, -1)),
//                                     BoxShadow(
//                                         color: Color(0xffffffff),
//                                         offset: Offset(1, 1))
//                                   ]),
//                               child: SizedBox(
//                                   width: 60,
//                                   height: 30,
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         child: Text(
//                                           '地域',
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                               child: SizedBox(
//                                 height: 35,
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                     contentPadding: EdgeInsets.all(10),
//                                     hintText: '地域',
//                                     hintStyle: TextStyle(fontSize: 12),
//                                     enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0)),
//                                         borderSide: BorderSide(
//                                             color: Color(0xffD9D9D9))),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0)),
//                                         borderSide: BorderSide(
//                                             color: Color(0xffD9D9D9))),
//                                   ),
//                                   onChanged: (text) {
//                                     model.danka.address = text;
//                                   },
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 40,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(
//                             width: 40,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                                 color: Color(0xffFBFAF5),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(7)),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Color(0xffB3B3B3),
//                                       offset: Offset(-1, -1)),
//                                   BoxShadow(
//                                       color: Color(0xffffffff),
//                                       offset: Offset(1, 1))
//                                 ]),
//                             child: SizedBox(
//                                 width: 60,
//                                 height: 30,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       child: Text(
//                                         '仏飯',
//                                         style: TextStyle(fontSize: 12),
//                                       ),
//                                     ),
//                                   ],
//                                 )),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           CupertinoSwitch(
//                             value: buppanState,
//                             onChanged: (value) {
//                               setState(() => buppanState = value);
//                               model.danka.buppanFlg =
//                                   model.ConvertBoolToInt(buppanState);
//                             },
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 12, bottom: 12),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: 40,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Color(0xffFBFAF5),
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(7)),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Color(0xffB3B3B3),
//                                         offset: Offset(-1, -1)),
//                                     BoxShadow(
//                                         color: Color(0xffffffff),
//                                         offset: Offset(1, 1))
//                                   ]),
//                               child: SizedBox(
//                                   width: 60,
//                                   height: 30,
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         child: Text(
//                                           'その他',
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                               child: TextField(
//                                 keyboardType: TextInputType.multiline,
//                                 maxLines: 10,
//                                 decoration: InputDecoration(
//                                   contentPadding: EdgeInsets.all(10),
//                                   hintText: 'その他',
//                                   hintStyle: TextStyle(fontSize: 12),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10.0)),
//                                       borderSide:
//                                           BorderSide(color: Color(0xffD9D9D9))),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10.0)),
//                                       borderSide:
//                                           BorderSide(color: Color(0xffD9D9D9))),
//                                 ),
//                                 onChanged: (text) {
//                                   model.danka.others = text;
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               width: 40,
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       SizedBox(
//                         width: 75,
//                         height: 30,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10)),
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: Color(0xff404040),
//                                     offset: Offset(1, 1),
//                                     blurRadius: 3),
//                                 BoxShadow(
//                                     color: Color(0xffffffff),
//                                     offset: Offset(-1, -1),
//                                     blurRadius: 3)
//                               ]),
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10)),
//                                   backgroundColor: Color(0xffFBFAF5),
//                                   foregroundColor: Color(0xffffaebd7),
//                                   elevation: 0,
//                                   shadowColor: Color(0xff404040)),
//                               child: Text(
//                                 '追加',
//                                 style: TextStyle(
//                                     fontSize: 12, color: Color(0xff000000)),
//                               ),
//                               onPressed: () async {
//                                 try {
//                                   model.startLoading();
//                                   await model.addDanka();
//                                   Navigator.of(context).pop(model.danka.name);
//                                 } catch (e) {
//                                   final snackBar = SnackBar(
//                                     backgroundColor: Colors.red,
//                                     content: Text(e.toString()),
//                                   );
//                                   ScaffoldMessenger.of(context)
//                                       .showSnackBar(snackBar);
//                                 } finally {
//                                   model.endLoading();
//                                 }
//                               }),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ]);
//               }),
//             )));
//   }
// }

