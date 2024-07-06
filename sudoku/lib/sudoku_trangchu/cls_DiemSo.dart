import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      print('Getting documents directory path...');
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, 'sudoku_game.db');
      print('Database path: $path');
      
      print('Opening database...');
      Database db = await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
      print('Database opened successfully');
      return db;
    } catch (e) {
      print('Error initializing database: $e');
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      print('Creating tables...');
      await db.execute('''
        CREATE TABLE game_results(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          result REAL,
          minutes INTEGER,
          seconds INTEGER,
          level TEXT
        )
      ''');
      print('Tables created successfully');
    } catch (e) {
      print('Error creating tables: $e');
      rethrow;
    }
  }

  Future<int> insertGameResult(Map<String, dynamic> result) async {
    try {
      Database db = await database;
      int id = await db.insert('game_results', result);
      return id;
    } catch (e) {
      print('Error inserting game result: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchGameResults() async {
    try {
      Database db = await database;
      print('Fetching game results...');
      List<Map<String, dynamic>> results = await db.query('game_results');
      print('Game results fetched: $results');
      return results;
    } catch (e) {
      print('Error fetching game results: $e');
      rethrow;
    }
  }

  Future<double> fetchHighestResult(String level) async {
    print(level);
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.rawQuery('''
        SELECT MAX(result) as highestResult
        FROM game_results
        WHERE level = ?
      ''', [level == "easy" ? "Dễ" : "Khó"]);
      print(result);
      return result.first['highestResult'] ?? 0.0;
    } catch (e) {
      print('Error fetching highest result: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchGameResultsByLevel(String level) async {
  try {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'game_results',
      where: 'level = ?',
      whereArgs: [level],
    );
    return results;
  } catch (e) {
    print('Error fetching game results by level: $e');
    rethrow;
  }
}
}