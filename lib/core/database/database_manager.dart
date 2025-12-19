import 'package:moneybox_task/core/constants/app_constants.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseManager._internal();

  static final DatabaseManager _instance = DatabaseManager._internal();

  static DatabaseManager get instance => _instance;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath/userData.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE ${AppConstants.tableName} (id TEXT PRIMARY KEY,currentStep INTEGER,businessName TEXT,businessType TEXT,registrationNumber TEXT,yearsInOperation TEXT,applicantName TEXT,panCard TEXT,aadhaarNumber TEXT,mobileNumber TEXT,emailAddress TEXT,loanAmount REAL,tenure TEXT,loanPurpose TEXT)',
        );
      },
    );
  }
}
