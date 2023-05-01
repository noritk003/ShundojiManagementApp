import 'package:flutter/material.dart';

import 'add_danka/AddDankaPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddDankaPage(),
    );
  }
}