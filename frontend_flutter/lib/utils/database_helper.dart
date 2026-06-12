import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('forensic_logs.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        filename TEXT NOT NULL,
        prediction TEXT NOT NULL,
        confidence_score REAL NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertLog(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('logs', row);
  }

  Future<int> getLogsCount() async {
    final db = await instance.database;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM logs'),
    );
    return count ?? 0;
  }

  Future<List<Map<String, dynamic>>> getAllLogs() async {
    final db = await instance.database;
    return await db.query('logs', orderBy: 'timestamp DESC');
  }

  Future<int> clearAllLogs() async {
    final db = await instance.database;
    return await db.delete('logs');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
