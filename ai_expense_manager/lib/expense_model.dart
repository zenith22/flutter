// database table and column names
import 'package:ai_expense_manager/datetime_formatter.dart';

const table = 'expense_tracker';

const columnId = '_id';
const columnAmount = 'amount';
const columnCategory = 'category';
const columnDateTime = 'timestamp';

class ExpenseModel {
  int? id;
  int expenseAmount;
  int expenseCategory;
  String expenseDateTime;

  ExpenseModel(
      {required this.expenseAmount,
      required this.expenseCategory,
      required this.expenseDateTime,
      this.id});

  @override
  String toString() {
    return '\nid = $id and expenseAmount = $expenseAmount and expenseCategory = $expenseCategory and expenseDateTime = $expenseDateTime';
  }

  fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    expenseAmount = map[columnAmount];
    expenseCategory = map[columnCategory];
    expenseDateTime = MyDateTimeFormatter.getFormattedDate(map[columnDateTime]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnId: id,
      columnAmount: expenseAmount,
      columnCategory: expenseCategory,
      columnDateTime: MyDateTimeFormatter.getEpochTimeStamp(expenseDateTime)
    };
    return map;
  }
}
