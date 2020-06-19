import 'package:flutter/material.dart';
import 'package:sqlitedemo/models/product.dart';
import 'package:sqlitedemo/screens/product_add.dart';
import 'package:sqlitedemo/screens/product_detail.dart';
import 'package:sqlitedemo/screens/product_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var product = Product(name: "Ipad",description: "Fast tablet",unitPrice: 850);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home:ProductDetail(this.product),//Product add'e gidiyor ama liste gitmiyor.

      );

  }

}