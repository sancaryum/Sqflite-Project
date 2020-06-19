import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlitedemo/data/dbHelper.dart';
import 'package:sqlitedemo/models/product.dart';

enum Options{delete,update}//enumlar classlar gibi yapılardır. Class dışında tanımlanırlar.

class ProductDetail extends StatefulWidget{
  Product product;
  ProductDetail(this.product);//?





  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }


}

class _ProductDetailState extends State {
  Product product;
  _ProductDetailState(this.product);//?

  var dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details of product: $product.name)"),
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context)=><PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value:Options.delete,
                child:Text("Sil"),
              ),
              PopupMenuItem<Options>(
                value:Options.update,
                child:Text("Güncelle"),
              ),

            ],
          )
        ],
      ),
      body:
        buildProductDetail (),
    );
  }

  buildProductDetail() {}



  selectProcess(Options options) async {
    switch(options){
      case Options.delete:
        await dbHelper.delete(product.id);
        Navigator.pop(context,true);//True giderse güncelle orayı demek
        break;
      default:

    }
  }
}

