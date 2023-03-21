import 'package:ai_expense_manager/datetime_formatter.dart';
import 'package:flutter/material.dart';

class ListExpense extends StatefulWidget {
  const ListExpense({super.key});

  @override
  State<ListExpense> createState() => _ListExpenseState();
}

class _ListExpenseState extends State<ListExpense>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
        child: Text(
            'List of expenses - ${MyDateTimeFormatter.getFormattedDateTime(DateTime.now())}'));
  }

  @override
  bool get wantKeepAlive => true;
}
