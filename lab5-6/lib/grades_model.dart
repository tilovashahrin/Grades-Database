import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'grade.dart';

class GradeModel{
  var database;

  Future<void> init() async{
    database = await openDatabase(
      path.join(await getDatabasesPath(), 'grades.db'),
      onCreate: (db, version){
        db.execute("CREATE TABLE grades(id INTEGER PRIMARY KEY, sid TEXT, grade TEXT)");
      },
    version: 1,
    );
    print("intiating db");

    int response = await database.insert('grades',
    {"id": 3, "sid": "100732448", "grade": "A"}, ConflictAlgorithm.replace);
    print("$response");
  }

  Future<void> insertGrade(Grade grade) async {
    if(this.database == null){
      await init();
    }
    print("writing data");
    print(grade.toMap());
    Type type = grade.toMap()['id'].runtimeType;
    print("A int? ${type == int}");

    await database.insert(
        'grades',
        grade.toMap(), ConflictAlgorithm.replace);
  }

  Future<void> updateGrade(Grade grade) async {
    if (this.database == null){
      await init();
    }
    await database.update('grades', grade.toMap(), where: r"id = ?", whereArgs: [grade.id]);
  }

  Future<void> deleteGradeById(int id) async {
    if (this.database == null){
      await init();
    }
    await database.update('grades', where: "id = ?", whereArgs: [id]);
  }

  Future<List<Grade>> getAllGrades() async{
    if (this.database == null){
      await init();
    }

    final List<Map<String, dynamic>> maps = await database.query('grades');
    List<Grade> grades = [];

    if (maps.length > 0){
      for(int i = 0; i < maps.length; i++){
        grades.add(Grade.fromMap(maps[i]));
      }
    }
    return grades;
  }
}