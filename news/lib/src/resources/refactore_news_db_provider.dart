import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';  //path provider module is specifically made to work with mobile devices temporary directories or directories on mobile devices
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
//import 'repository.dart';   //once we done refactor we will comment down the below import.
import 'refactor_repository.dart';

class NewsDbProvider implements Source,Cache{
  Database db;

/*
with our DB provider we had been expecting to call this init function before we actually make use of the thing.So we created a constructor to call init method on our
NewsDbProvider.
 */

  NewsDbProvider() {
    init();
  }

  Future<List<int>> fetchTopIds() {
    return null;  // this is just a fake implementation.
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, "items4.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE Items
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
        """);
      },
    );
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if(maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(
        "Items",
        item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,    //22.31 easy way to remove error on exception thrown for unique Id. 2nd way is in refacotr_repository.dart file.
    );
  }

  Future<int> clear() {       //22.41
    return db.delete("Items");   //22.41
  }
}

final newsDbProvider = NewsDbProvider();    //21.11
