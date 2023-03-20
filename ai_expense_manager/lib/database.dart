import 'dart:io';

import 'package:ai_expense_manager/expense_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'datetime_formatter.dart';

class DatabaseHelper {
  static const _databaseName = "ai_expense_tracker.db";
  static const _databaseVersion = 1;

  static const table = 'expense_tracker';

  static const columnId = '_id';
  static const columnAmount = 'amount';
  static const columnCategory = 'category';
  static const columnDateTime = 'timestamp';

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static late Database _database;

  // open the database
  initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database, can also add an onUpdate callback parameter.
    _database = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $table($columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $columnAmount INTEGER, 
        $columnCategory INTEGER,
        $columnDateTime INTEGER)''');
  }

  Future<int> insert(ExpenseModel expenseModel) async {
    int id = await _database.insert(table, expenseModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<ExpenseModel>> fetchExpenses() async {
    final List<Map<String, dynamic>> maps = await _database.query(table);

    return List.generate(maps.length, (index) {
      return ExpenseModel(
          expenseAmount: maps[index][columnAmount],
          expenseCategory: maps[index][columnCategory],
          expenseDateTime:
              MyDateTimeFormatter.getFormattedDate(maps[index][columnDateTime]),
          id: maps[index][columnId]);
    });
  }
}
