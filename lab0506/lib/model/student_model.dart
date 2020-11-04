import 'dart:async';
import 'package:sqflite/sqflite.dart';

import 'db_utils.dart';
import 'student.dart';

class StudentModel {
  Future<int> insertStudent(Student student) async {
    final db = await DBUtils.init();
    return db.insert(
      'students',
      student.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateStudent(Student student) async {
    final db = await DBUtils.init();
    await db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<void> deleteStudentById(int id) async {
    final db = await DBUtils.init();
    await db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Student>> getAllStudents() async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query('students');
    List<Student> result = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(Student.fromMap(maps[i]));
      }
    }
    return result;
  }

  /*
  Future<Student> getStudentWithId(String id) async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
    return Student.fromMap(maps[0]);
  }
  */
}
