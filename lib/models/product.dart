class Product{
  int id;
  String name,description;
  double unitPrice;

  //Burada süslü parantez parametre atarken türünü vererek atamamızı zorunlu kılar
  Product({this.name,this.description,this.unitPrice});//Id olmadan constructor
  Product.withId({this.id,this.name,this.description,this.unitPrice});//içerdeki süslüler kaldırılabilir

  /*
  Format:String
  Dynamic: Tüm veri tiplerini verebiliriz
  Objeyi mape çevirir
  */
  Map<String,dynamic> toMap(){
    /*
       Burdaki map objesi String tutacak ve dynamic(her veriyi alabilen olacak)

     */
    var map = new Map<String,dynamic>();//Dartta new'e gerek yok
    map["name"] = name;
    map["description"] = description;
    map["unitPrice"] = unitPrice;
    if(id!=null) {
      map["id"] = id;
    }

  }

  //Parametre olarak dinamik bir şekilde veri olarak map gelecek. Bizde onu objeye atacağız
  Product.fromObject(dynamic o){
    this.id = int.tryParse(o["id"]);//Gelen veriyi inte çevirir
    this.name= o["name"];
    this.description=o["descriptipn"];
    this.unitPrice=double.tryParse(o["unitPrice"]);//Gelen veriyi double'a çevirir

  }
}