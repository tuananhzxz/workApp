import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:workspace/Class/work.dart';

class DatabaseW {
  final DatabaseName = "work.db";

  String work = '''
  CREATE TABLE works (
    workId INTEGER PRIMARY KEY AUTOINCREMENT, 
    title TEXT UNIQUE,
    content TEXT 
  )
  ''';

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, DatabaseName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(work);
    });
  }

  Future<int> createWork(Work work) async {
    final Database db = await initDB();
    return db.insert("works", work.toMap());
  }

  Future<int> delateWork(int workId) async {
    final Database db = await initDB();
    // await db.rawQuery('DELETE FROM works WHERE title="${work.title}"');

    return db.delete('works', where: "workId = ?", whereArgs: [workId]);
  }

  // Future<List<Map<String, dynamic>>> getAllData() async {
  //   final Database db = await initDB();
  //   return db.query('works', orderBy: 'workId');
  // }

  Future<List<Work>> getWork() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> QueryResult =
        await db.rawQuery('SELECT * FROM works');
    return QueryResult.map((e) => Work.fromMap(e)).toList();
  }

  Future<int> updateWork(int workId, String title, String content) async {
    final Database db = await initDB();
    var data = {'title': title, 'content': content};
    var result = await db
        .update('works', data, where: "workId = ?", whereArgs: [workId]);
    return result;
  }
}
