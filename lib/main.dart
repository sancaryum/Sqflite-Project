import 'package:flutter/material.dart';
import 'package:sqlitedemo/screens/product_add.dart';
import 'package:sqlitedemo/screens/product_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home:ProductList(),//Product add'e gidiyor ama liste gitmiyor.

      );

  }

}