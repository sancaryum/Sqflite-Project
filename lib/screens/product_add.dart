import 'package:flutter/material.dart';
import 'package:sqlitedemo/data/dbHelper.dart';
import 'package:sqlitedemo/models/product.dart';

class ProductAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }


}

class ProductAddState extends State{
  var dbHelper = DbHelper();
  var txtName = TextEditingController(); //Aynısı: TextEditingController txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new product"),
      ),
      body:Padding(//Padding widgetı bir padding işlemi gerçekleştiriyor
        padding: EdgeInsets.all(30.0),
        child: Column(//Column sayesinde birden fazla widget türünü alt alta koyabiliriz
          children: <Widget>[
            //Alttaki 3 ünü tek metod altında parametreye göre yapılandırarak da yapabilirdik
            buildNameField(),
            buildDescriptionFields(),
            buildUnitPriceField(),
            buildSaveButton()
          ],
        ),
      )
    );
  }

  //BU BUILDLERIN BAŞINA WIDGET, TEXTFIELD DE YAZILABİLİR.
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

  buildSaveButton() {
    return FlatButton(
      child: Text("Add"),
      onPressed:(){
        print("Add pressed");
        addProduct();

      },

    );

  }

  void addProduct() async {  //Operasyonlarda async
    var result = await dbHelper.insert(Product(name:txtName.text,description:txtDescription.text,unitPrice:double.tryParse(txtUnitPrice.text)));
    Navigator.pop(context,true);

  }


}