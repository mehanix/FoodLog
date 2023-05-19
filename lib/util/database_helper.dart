import 'dart:io';
import 'package:dezvapmobile/model/FoodLog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'FoodLogDatabase.db';
  static const _databaseVersion = 1;

  //singleton class
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    print(dbPath);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    //create tables
    await db.execute('''
      CREATE TABLE ${FoodLog.tableName}(
        ${FoodLog.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${FoodLog.colFoodName} TEXT NOT NULL,
        ${FoodLog.colCalories} INTEGER NOT NULL,
        ${FoodLog.colDate} DATE NOT NULL,
        ${FoodLog.colPhoto} TEXT
      )
      ''');
  }

  //contact - insert
  void insertFoodLog(FoodLog log) async {
    Database db = await database;
    await db.insert(FoodLog.tableName, log.toMap());
  }

//contact - update
  Future<int> updateFoodLog(FoodLog log) async {
    Database db = await database;
    return await db.update(FoodLog.tableName, log.toMap(),
        where: '${FoodLog.colId}=?', whereArgs: [log.id]);
  }

//contact - delete
  Future<int> deleteFoodLog(int id) async {
    Database db = await database;
    return await db.delete(FoodLog.tableName,
        where: '${FoodLog.colId}=?', whereArgs: [id]);
  }

//contact - retrieve all
  Future<List<FoodLog>> fetchFoodLogs() async {
    Database db = await database;
    List<Map> logs = await db.query(FoodLog.tableName);
    return logs.isEmpty ? [] : logs.map((x) => FoodLog.fromMap(x)).toList();
  }
}
