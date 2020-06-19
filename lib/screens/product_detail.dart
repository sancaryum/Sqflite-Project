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
  var txtName = TextEditingController(); //Aynısı: TextEditingController txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();


  @override
  void initState() {
    txtName.text=product.name;
    txtDescription.text=product.description;
    txtUnitPrice.text=product.unitPrice.toString();
  }

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



  selectProcess(Options options) async {
    switch(options){
      case Options.delete:
        await dbHelper.delete(product.id);
        Navigator.pop(context,true);//True giderse güncelle orayı demek
        break;
      case Options.update:
        await dbHelper.update(Product.withId(id:product.id,name:txtName.text,description: txtDescription.text,unitPrice: double.tryParse(txtUnitPrice.text)));
        Navigator.pop(context,true);//True giderse güncelle orayı demek
        break;
      default:

    }
  }


  buildProductDetail() {

    return Padding(//Padding widgetı bir padding işlemi gerçekleştiriyor
      padding: EdgeInsets.all(30.0),
      child: Column(//Column sayesinde birden fazla widget türünü alt alta koyabiliriz
        children: <Widget>[
          //Alttaki 3 ünü tek metod altında parametreye göre yapılandırarak da yapabilirdik
          buildNameField(),
          buildDescriptionFields(),
          buildUnitPriceField(),

        ],
      ),
    );

  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Name of product"),
      controller: txtName,//Bu field'in conrolleri kimdir diyor


    );

  }

  buildDescriptionFields() {
    return TextField(
      decoration: InputDecoration(labelText: "Description off product"),
      controller: txtDescription,
    );
  }

  buildUnitPriceField(){
    return TextField(
      decoration: InputDecoration(labelText: "Unit price off product"),
      controller: txtUnitPrice,
    );
  }


}

