import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? db;

  Future<Database> get database async {
    if (db != null) {
      return db!;
    }
    db = await initDb();
    return db!;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'token.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE token(
            id INTEGER PRIMARY KEY,
            token TEXT,
            day INTEGER,
            month INTEGER,
            year INTEGER
          )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS token');
        await db.execute('''
        CREATE TABLE token(
          id INTEGER PRIMARY KEY,
          token TEXT,
          day INTEGER,
          month INTEGER,
          year INTEGER
        )
      ''');
      },
    );
  }

  // save token to local storage
  Future<void> saveToken(String token, int day, int month, int year) async {
    final db = await database;
    final localToken = await getToken();
    final isExpired = await isTokenExpired();
    if (localToken['token'] != '' && !isExpired) {
      await db.update(
        'token',
        {'token': token, 'day': day, 'month': month, 'year': year},
        where: 'id = ?',
        whereArgs: [1],
      );
    } else {
      await db.insert('token', {
        'id': 1,
        'token': token,
        'day': day,
        'month': month,
        'year': year,
      });
    }
  }

  // get token from local storage
  Future<Map<String, dynamic>> getToken() async {
    final db = await database;
    final result = await db.query('token');
    if (result.isNotEmpty) return result.first;
    return {'token': '', 'day': 0, 'month': 0, 'year': 0};
  }

  Future<bool> isTokenExpired() async {
    final result = await getToken();
    if (result == null) return true;
    final int expDay = result['day'];
    final int expMonth = result['month'];
    final int expYear = result['year'];
    final expirationDate = DateTime(expYear, expMonth, expDay);
    final today = DateTime.now();
    return expirationDate.isBefore(
      DateTime(today.year, today.month, today.day),
    );
  }
}
