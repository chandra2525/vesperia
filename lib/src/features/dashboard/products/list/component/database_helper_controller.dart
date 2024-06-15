import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'favorite_products.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorite_products (
        id TEXT PRIMARY KEY,
        name TEXT,
        price INTEGER,
        discountPrice INTEGER,
        imageUrl TEXT
      )
    ''');
  }

  Future<int> insertFavorite(Map<String, dynamic> product) async {
    var dbClient = await database;
    return await dbClient.insert('favorite_products', product);
  }

  Future<int> deleteFavorite(String id) async {
    var dbClient = await database;
    return await dbClient
        .delete('favorite_products', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    var dbClient = await database;
    return await dbClient.query('favorite_products');
  }

  Future<bool> isFavorite(String id) async {
    var dbClient = await database;
    var res = await dbClient
        .query('favorite_products', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty;
  }

  Future<void> clearFavorites() async {
    var dbClient = await database;
    await dbClient.delete('favorite_products');
  }
}
