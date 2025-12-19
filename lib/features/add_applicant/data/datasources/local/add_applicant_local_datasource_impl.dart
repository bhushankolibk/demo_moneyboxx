import 'package:moneybox_task/core/constants/app_constants.dart';
import 'package:moneybox_task/core/database/database_manager.dart';
import 'package:moneybox_task/features/add_applicant/data/datasources/local/add_applicant_local_datasource.dart';
import 'package:moneybox_task/features/add_applicant/data/models/loan_applicant_model.dart';
import 'package:sqflite/sqflite.dart';

class AddApplicantLocalDatasourceImpl extends AddApplicantLocalDatasource {
  @override
  Future<void> saveDraft(LoanApplicationModel draft) async {
    final db = await DatabaseManager.instance.database;
    // ConflictAlgorithm.replace is crucial for "Auto-save".
    // It updates the row if the ID exists, or inserts if it's new.
    await db.insert(
      AppConstants.tableName,
      draft.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<LoanApplicationModel?> getLastDraft() async {
    final db = await DatabaseManager.instance.database;
    final maps = await db.query(
      AppConstants.tableName,
      where: 'currentStep != ?',
      whereArgs: [4],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return LoanApplicationModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<void> deleteDraft(String id) async {
    final db = await DatabaseManager.instance.database;
    await db.delete(AppConstants.tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<LoanApplicationModel>> getLoanApplicants() async {
    final db = await DatabaseManager.instance.database;
    final maps = await db.query(AppConstants.tableName);
    return maps.map((e) => LoanApplicationModel.fromMap(e)).toList();
  }
}
