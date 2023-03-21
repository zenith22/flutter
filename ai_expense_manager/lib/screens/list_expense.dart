import 'package:ai_expense_manager/database.dart';
import 'package:ai_expense_manager/datetime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:ai_expense_manager/expense_model.dart';
import 'package:ai_expense_manager/constants.dart';

class ListExpense extends StatefulWidget {
  const ListExpense({super.key});

  @override
  State<ListExpense> createState() => _ListExpenseState();
}

class _ListExpenseState extends State<ListExpense>
    with AutomaticKeepAliveClientMixin {
  late Future<List<ExpenseModel>> expenseList;

  @override
  void initState() {
    super.initState();
    expenseList = DatabaseHelper.instance.fetchExpenses();
  }

  ListView expenseListView(AsyncSnapshot<List<ExpenseModel>> snapshot) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: snapshot.data?.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.cyan),
              color: Colors.lightGreenAccent,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Text('Amount = ${snapshot.data![index].expenseAmount}'),
              Text(
                  'Category = ${Constants.list[snapshot.data![index].expenseCategory]}'),
              Text(snapshot.data![index].expenseDateTime),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: FutureBuilder<List<ExpenseModel>>(
        future: expenseList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return expenseListView(snapshot);
          } else if (snapshot.hasError) {
            return Text('Some error has occurred ${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
