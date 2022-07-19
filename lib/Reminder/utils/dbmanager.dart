import 'dart:async';
import "package:flutter/foundation.dart";
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbTaskManager {
  Database _database;
  Task task;
  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "remember.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE task(id INTEGER PRIMARY KEY autoincrement, task TEXT, date TEXT, done INT)",
        );
      });
    }
  }

  Future<int> insertTask(Task task) async {
    await openDb();
    return await _database.insert('task', task.toMap());
  }

  Future<List<Task>> getTaskList() async {
    await openDb();
    final sql = '''SELECT * FROM task
    WHERE done = 0 ''';
    final List<Map<String, dynamic>> maps = await _database.rawQuery(sql);
    final List<Map<String, dynamic>> temp = new List<Map<String, dynamic>>();

    for (int i = 0; i < maps.length; i++) {
      DateTime target = DateTime.parse(maps[i]['date']);
      DateTime skrg = DateTime.now();
      Duration d = target.difference(skrg);
      if (d.inDays >= 0 && d.inDays <= 3) {
        temp.add(maps[i]);
      }
    }

    return List.generate(temp.length, (i) {
      return Task(
          id: temp[i]['id'],
          task: temp[i]['task'],
          done: temp[i]['done'],
          date: temp[i]['date']);
    });
  }

  Future<List<Task>> getTaskListMorethan3days() async {
    await openDb();
    final sql = '''SELECT * FROM task
    WHERE done = 0 ''';
    final List<Map<String, dynamic>> maps = await _database.rawQuery(sql);
    final List<Map<String, dynamic>> temp = new List<Map<String, dynamic>>();

    for (int i = 0; i < maps.length; i++) {
      DateTime target = DateTime.parse(maps[i]['date']);
      DateTime skrg = DateTime.now();
      Duration d = target.difference(skrg);
      if (d.inDays > 3 && d.inDays <= 7) {
        temp.add(maps[i]);
      }
    }

    return List.generate(temp.length, (i) {
      return Task(
          id: temp[i]['id'],
          task: temp[i]['task'],
          done: temp[i]['done'],
          date: temp[i]['date']);
    });
  }

  Future<List<Task>> getTaskListMorethan7days() async {
    await openDb();
    final sql = '''SELECT * FROM task
    WHERE done = 0 ''';
    final List<Map<String, dynamic>> maps = await _database.rawQuery(sql);
    final List<Map<String, dynamic>> temp = new List<Map<String, dynamic>>();

    for (int i = 0; i < maps.length; i++) {
      DateTime target = DateTime.parse(maps[i]['date']);
      DateTime skrg = DateTime.now();
      if (target.difference(skrg).inDays > 7) {
        temp.add(maps[i]);
      }
    }

    return List.generate(temp.length, (i) {
      return Task(
          id: temp[i]['id'],
          task: temp[i]['task'],
          done: temp[i]['done'],
          date: temp[i]['date']);
    });
  }

  Future<List<Task>> getArsip() async {
    await openDb();
    final sql = '''SELECT * FROM task
    WHERE done = 1 ''';
    final List<Map<String, dynamic>> maps = await _database.rawQuery(sql);
    final List<Map<String, dynamic>> temp = new List<Map<String, dynamic>>();

    for (int i = 0; i < maps.length; i++) {
      temp.add(maps[i]);
    }

    return List.generate(temp.length, (i) {
      return Task(
          id: temp[i]['id'],
          task: temp[i]['task'],
          done: temp[i]['done'],
          date: temp[i]['date']);
    });
  }

  Future<int> updateTask(Task task) async {
    await openDb();
    final sql = '''UPDATE task
    SET done = 1
    WHERE id = ${task.id}
    ''';

    List<dynamic> params = [task.id, task.done];
    final result = await _database.rawUpdate(sql);
  }

  Future<void> deleteTask(int id) async {
    await openDb();
    await _database.delete('task', where: "id = ?", whereArgs: [id]);
  }
}

class Task {
  int id;
  String task;
  String date;
  int done = 0;
  Task({this.task, this.date, this.id, this.done});

  Map<String, dynamic> toMap() {
    return {'task': task, 'date': date, 'done': done};
  }
}
