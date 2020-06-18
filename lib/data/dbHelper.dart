import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlitedemo/models/product.dart';

class DbHelper{

  Database _db;


  //Future ile bu yapı çalışacak, söz veriyoruz. ancak ilerde çalışacak diyoruz. İşlem borusunu gönderiyoruz, yanıt ne zaman gelirse.
  Future<Database> get db async{//Database objesi döndürecek
    if(db==null){
      _db= await initializeDb();/*initializeDb future olursa
      database oluşturmadan yoluna devam edemeyeceği için oluşturana kadar await, yani bekle diyoruz.
      */
      
    }
    return db;//Daha önce veritabanı oluşturulduysa olan veritabanını döndür
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(),"sancaryum.db"); 
    /*açması için veritabanının yolunu ister,versionlarını kontrol edebiliriz, Eğer veri tabanı yoksa createDb çalıştır.*/
    var sancaryumDb = await openDatabase(dbPath,version:1,onCreate: createDb);
    return sancaryumDb;
    
    
 
  }
   
    

  void createDb(Database db, int version) async {
    await db.execute("Create table products(id integer primary key,name text,descption text,unitPrice integer)");
  }

  //Product objeleri listesi olarak döndürüyoruz
  Future<List<Product>> getProducts() async{
    Database db = await this.db; //database objemizi döndürüyoruz
    var result = await db.query("products");//Tablo adını veriyoruz.Tablonun içindeki tüm verileri liste şeklinde bize veriyor
    return List.generate(result.length, (i){//Oluşturulan Product objeleri listeye ekleniyor
      return Product.fromObject(result[i]);//Constructordan Product oluşturduk
    });
  }


  //int yazılır çünkü kayıt eklenip eklenememesine göre 1 veya 0 döndürür.int ile kaç tane kayıt etkileniyorsa onu döndürür
  //int kullanılmayabilir de yerine void yazılabilir veya komple silinebilir. Farketmez
  Future<int> insert(Product product)async{
    Database db = await this.db;
    var result = await db.insert("products",product.toMap());
  }

  //O indexteki elemanı siler ve silinen elemanı string olarak döndürür
  Future<int> delete(int id)async{
    Database db =  await this.db;
    //Verilen id
    var result = db.rawDelete("delete from products where id=$id");
    return result;
  }

  Future<int> update(Product product)async{
    //Veri tabanını gösteriyoruz
    Database db = await this.db;
    /*products tablosuna güncel product mapini gönderiyoruz*/
    var result = await db.update("products", product.toMap(),where: "id=?",whereArgs: [product.id] );
    return result;//result burada güncellenen product objesi

  }


}