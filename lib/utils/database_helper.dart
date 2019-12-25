import 'dart:io';
import 'package:diary/model/Story.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper databaseHelper;
  Database _database;
  DatabaseHelper.createInstance();

  String storyTable = 'storyTable';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colFeeling = 'feeling';
  String colReason = 'reason';
  String colNote = 'note';

  //make it singleton object
  factory DatabaseHelper() {
    if (databaseHelper == null) {
      databaseHelper = DatabaseHelper.createInstance();
    }

    return databaseHelper;
  }

  //make database object singleton
  Future<Database> get database async {
    if (_database == null) _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    //get directory path to both android and ios to store database
    Directory directory = await getApplicationDocumentsDirectory();

    //below line produce error in iOS
    // String path = directory.path + 'notes.db';
    String path = join(directory.path, 'story.db');

    //open/create db at give path
    var noteDatabase = await openDatabase(path, version: 1, onCreate: createDb);
    return noteDatabase;
  }

  void createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $storyTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colTitle TEXT,$colDate TEXT,$colFeeling Text, $colReason INTEGER, $colNote TEXT)');
  }

  //Fetch operation. Get all note object from database
  Future<List<Map<String, dynamic>>> getStoryMapList() async {
    //get refrence to database
    Database db = await this.database;

    // var result = db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    //alternative of above query is
    var result = await db.query(storyTable);
    return result;
  }

  //Insert Operation
  Future<int> insertStory(Story story) async {
    //get refrence to database
    Database db = await this.database;

    //first convert note object into map
    var result = await db.insert(storyTable, story.toMap());
    return result;
  }

  //Update Operation
  Future<int> updateStory(Story story) async {
    //get refrence to database
    Database db = await this.database;

    //first convert note object into map
    var result = await db.update(storyTable, story.toMap(),
        where: '$colId = ?', whereArgs: [story.id]);
    return result;
  }

  //Delete Operation
  Future<int> deleteStory(int id) async {
    //get refrence to database
    Database db = await this.database;

    //first convert note object into map
    var result = await db.delete(storyTable, where: '$colId = $id');
    return result;
  }

  //Delete Operation
  Future<int> getCount() async {
    //get refrence to database
    Database db = await this.database;

    //first convert note object into map
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $storyTable');
    var result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Story>> getStoryList() async {
    var storyMapList = await getStoryMapList();
    int count = storyMapList.length;

    List<Story> storyList = List<Story>();
    for (int i = 0; i < count; i++) {
      storyList.add(Story.fromMapObject(storyMapList[i]));
    }

    return storyList;
  }
}
