import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/shopCartModel.dart';

class ShopCartDBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "shop_cart.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE ShopCart(id INTEGER PRIMARY KEY, goodId TEXT, goodName TEXT, price DOUBLE, number INTEGER, totalPrice DOUBLE, isSelected INTEGER, imgs TEXT )");
    print("Created tables");
  }

  void insertCart(ShopCartModel cart) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO ShopCart(goodId, goodName, price, number, totalPrice, isSelected, imgs ) VALUES(' +
              '\'' +
              cart.goodId +
              '\'' +
              ',' +
              '\'' +
              cart.goodName +
              '\'' +
              ',' +
              '\'' +
              cart.price.toString() +
              '\'' +
              ',' +
              '\'' +
              cart.number.toString() +
              '\'' +
              ',' +
              '\'' +
              cart.totalPrice.toString() +
              '\'' +
              ',' +
              '\'' +
              cart.isSelected.toString() +
              '\'' +
              ',' +
              '\'' +
              cart.imgs +
              '\'' +
              ')');
    });
  }

  void updateCart() async{

  }
  Future<List<ShopCartModel>> getShopCartData() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM ShopCart');
    List<ShopCartModel> shopCartData = new List();
    for (int i = 0; i < list.length; i++) {
      shopCartData.add(ShopCartModel.fromJson(list[i]));
    }
    print(shopCartData.length);
    return shopCartData;
  }
}
