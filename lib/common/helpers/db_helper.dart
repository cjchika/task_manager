import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart' as sql;

import '../models/task_model.dart';

class DBHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("CREATE TABLE todos("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "title STRING, desc TEXT, date STRING,"
        "startTime STRING, endTime STRING,"
        "reminder INTEGER, repeat STRING,"
        "isCompleted INTEGER)");

    await database.execute("CREATE TABLE user("
        "id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0,"
        "verified INTEGER"
        ")");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("achieverchika", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createUser(int isVerified) async {
    final db = await DBHelper.db();

    final data = {
      'id': 1,
      'isVerified': isVerified,
    };

    final item = await db.insert("user", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return item;
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await DBHelper.db();
    return db.query('user', orderBy: 'id');
  }

  static Future<int> createTask(Task task) async {
    final db = await DBHelper.db();

    final item = await db.insert("todos", task.toJson(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return item;
  }

  static Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await DBHelper.db();
    return db.query('todos', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getTask(int id) async {
    final db = await DBHelper.db();
    return db.query('todos', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateTask(int id, String title, String desc,
      int isCompleted, String date, String startTime, String endTime) async {
    final db = await DBHelper.db();
    final data = {
      'title': title,
      'desc': desc,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime
    };
    final results = await db.update('todos', data, where: 'id = ?', whereArgs: [id]);
    return results;
  }

  static Future<void> deleteTask(int id) async {
    final db = await DBHelper.db();

    try {
      db.delete('todos', where: 'id = ?', whereArgs: [id]);
    } catch(e){
      debugPrint("Unable to delete");
    }
  }
}
