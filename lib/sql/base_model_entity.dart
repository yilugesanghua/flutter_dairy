import 'package:flutter_dairy/sql/sql_manager.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseModelEntity {
  BaseModelEntity();

  BaseModelEntity fromJson(Map<String, dynamic> json);

  Database _db;

  Map<String, dynamic> toDbJson();

  Future open() async {
    _db = await SqlManager.instance.getCurrentDatabase();
  }

  Future<int> insert(String tableName) async {
    await open();
    try {
      var values = toDbJson();
      print("vaules ===>  $values");
      return await _db?.insert(tableName, values);
    } catch (e) {
      print("插入失败  $e");
      return -1;
    } finally {
      await close();
    }
  }

  Future<BaseModelEntity> query(
      String tableName, String where, List<dynamic> whereArgs) async {
    await open();
    try {
      List<Map<String, dynamic>> maps =
          await _db?.query(tableName, where: where, whereArgs: whereArgs);
      if (maps != null && maps.isNotEmpty) {
        return fromJson(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      print("查询失败 $e");
      return null;
    } finally {
      await close();
    }
  }

  Future<List<BaseModelEntity>> queryAll(
      String tableName, String where, List<dynamic> whereArgs) async {
    await open();
    try {
      List<Map<String, dynamic>> maps =
          await _db?.query(tableName, where: where, whereArgs: whereArgs);
      if (maps.length > 0) {
        return List.generate(maps.length, (int index) {
          return fromJson(maps[index]);
        });
      } else {
        return null;
      }
    } catch (e) {
      print("查询失败 $e");
      return null;
    } finally {
      await close();
    }
  }

  Future<int> delete(
      String tableName, String where, List<dynamic> whereArgs) async {
    await open();
    try {
      return await _db?.delete(tableName, where: where, whereArgs: whereArgs);
    } catch (e) {
      print("删除失败 $e");
      return -1;
    } finally {
      await close();
    }
  }

  Future<int> update(
      String tableName, String where, List<dynamic> whereArgs) async {
    await open();
    try {
      return await _db?.update(tableName, toDbJson(),
          where: where, whereArgs: whereArgs);
    } catch (e) {
      print("更新失败 $e");
      return -1;
    } finally {
      await close();
    }
  }

  Future close() async => _db?.close();
}
