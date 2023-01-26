import 'dart:io';
import 'package:apiproject/todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseHelper {

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;



  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {

    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/toDoapp.db';


    var studentsDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return studentsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        '''CREATE TABLE ToDoTable (id integer primary key autoincrement,
         title text, note text, date text
        )''');
  }
  Future<int> addTask(ToDo todoObj) async {
    Database db = await instance.database;
    int result = await db.insert("ToDoTable", todoObj.todoMap());
    return result;
  }

  Future<List<ToDo>> read() async {
    var todo = <ToDo>[];

    Database db = await instance.database;
    var listMap = await db.query("ToDoTable");
    for (var todoMap in listMap) {
      ToDo toDDo = ToDo.fromMap(todoMap);
      todo.add(toDDo);
    }
    return todo;
  }
  //delete
  Future<int> delete(int id) async {
    Database db = await instance.database;
    int result = await db.delete("ToDoTable", where: "id=?", whereArgs: [id]);
    return result;
  }
  //Future<List<Map<String, Object?>>> read() async {
    //final Database db = await instance.database;
   //return await db.query("ToDoTable");
  }




