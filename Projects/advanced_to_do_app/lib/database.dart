import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:advanced_to_do_app/to_do_model.dart';

dynamic database;

  Future createDB() async {
    database = openDatabase(join(await getDatabasesPath(), "TasksDB.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE Task(
              taskId INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              description TEXT,
              date TEXT
            )
          ''');
      },
    );
    getData();
  }

  Future insertData(ToDoModelClass obj) async {
    final localDB = await database;
    await localDB.insert(
      "Task",
      obj.taskMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future getData() async {
    final localDB = database;
    List<Map<String, dynamic>> taskData = await localDB.query("Task");
    return List.generate(taskData.length, (idx) {
      return ToDoModelClass(
        taskId: taskData[idx]['taskId'],
        title: taskData[idx]['title'],
        description: taskData[idx]['description'],
        date: taskData[idx]['date'],
      );
    });
  }
