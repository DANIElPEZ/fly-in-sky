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
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE token(
            id INTEGER PRIMARY KEY,
            token TEXT,
            expires_date TEXT
          )
      ''');
      },
    );
  }

  // save token to local storage
  Future<void> saveToken(String token, String expiresDate) async {
    final db = await database;
    final token = await getToken();
    final isEspired = await isTokenExpired();
    if (token.isNotEmpty && !isEspired) {
      await db.update(
        'token',
        {'token': token, 'expires_date': expiresDate},
        where: 'id = ?',
        whereArgs: [1],
      );
    } else {
      await db.insert('token', {'token': token, 'expires_date': expiresDate});
    }
  }

  // get token from local storage
  Future<Map<String, dynamic>> getToken() async {
    final db = await database;
    final result= await db.query('token');
    if (result.isNotEmpty) return result.first;
    return {};
  }

  Future<bool> isTokenExpired() async {
    final result = await getToken();
    if (result==null) return true;
    final expiresDate = DateTime.tryParse(result['expires_date']);
    return DateTime.now().isAfter(expiresDate!);

  }
}
