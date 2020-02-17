import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/shopCartModel.dart';

class ShopCartDBHelper {
  static Database _db;
  String dataBaseName = "demo.db";
  String tableName = 'Shop_Cart';
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dataBaseName);
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // var delRes= await db.delete(tableName);
    // print('del');
    // print(delRes);
    // print('del===');

    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE $tableName(id INTEGER PRIMARY KEY, goodId TEXT, goodName TEXT, price INTEGER, number INTEGER, totalPrice INTEGER, isSelected INTEGER, imgs TEXT )");
    print("Created tables");
  }

  void insertCart(ShopCartModel cart) async {
    var dbClient = await db;
    var insertRes = await dbClient.insert(tableName, cart.toJson());
    print('insertRes is $insertRes');
  }

  void updateCart(ShopCartModel cart) async {
    var dbClient = await db;
    dbClient.update(tableName, cart.toJson(),
        where: "goodId = ?", whereArgs: [cart.goodId]);
  }

  Future<int> deleteCart(String goodId) async {
    var dbClient = await db;
    var delRes=await dbClient.delete(tableName, where: "goodId = ?", whereArgs: [goodId]);
    print('d $delRes');
    return delRes;
  }

  Future<List> getShopCartData() async {
    var dbClient = await db;
    var result = await dbClient.query(tableName);
    return result.toList();
  }
}
