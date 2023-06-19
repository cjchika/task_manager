import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart' as sql;

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
}
