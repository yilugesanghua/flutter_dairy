import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const TABLE_NOTE = "note";
const TABLE_BOOK = "book";
const _DB_NAME = "dailynote.crpt";

class SqlManager {
  factory SqlManager() => _getInstance();

  static SqlManager get instance => _getInstance();
  static SqlManager _instance;

  static SqlManager _getInstance() {
    if (_instance == null) {
      _instance = new SqlManager._internal();
    }
    return _instance;
  }

  SqlManager._internal() {
    ///初始化
    initDataBase();
  }

  //日记表
  Database _db;

  initDataBase() async {
    final String databasePath = await getDatabasesPath();
    // print(databasePath);
    final String path = join(databasePath, _DB_NAME);
    if (!await Directory(dirname(path)).exists()) {
      try {
        await Directory(dirname(path)).create(recursive: true);
        print("=======数据库初始化成功=========");
      } catch (e) {
        print("=======数据库初始化失败=========$e");
      }
    }
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE $TABLE_NOTE (id INTEGER PRIMARY KEY AUTOINCREMENT, sendTime INTEGER , title TEXT , content TEXT , temp REAL )");
      print("=======表创建成功=========");
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      print("=======onUpgrade=========");
      if (oldVersion == 1 && newVersion == 2) {
        await db.execute(
            "CREATE TABLE $TABLE_BOOK (id INTEGER PRIMARY KEY AUTOINCREMENT, code INTEGER , msg TEXT  )");
        print("=======表二创建成功=========");
      }
    }, onDowngrade: (Database db, int oldVersion, int newVersion) async {
      print("=======onDowngrade=========");
    }, onOpen: (Database db) {
      print("=========onOpen=========");
    });
    print("=======数据库初始化成功end=========");
  }

  ///获取当前数据库对象
  Future<Database> getCurrentDatabase() async {
    if (_db == null || !_db.isOpen) {
      await initDataBase();
    }
    return _db;
  }

  ///关闭
  close() {
    _db?.close();
    _db = null;
  }
}
