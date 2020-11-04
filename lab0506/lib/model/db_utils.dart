import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future<Database> init() async {
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'students.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE students(id INTEGER PRIMARY KEY, sid TEXT, grade TEXT)');
      },
      version: 2,
    );
    return database;
  }
}
