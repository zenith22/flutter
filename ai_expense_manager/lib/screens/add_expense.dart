import 'package:ai_expense_manager/constants.dart';
import 'package:flutter/material.dart';
import 'package:ai_expense_manager/database.dart';
import 'package:ai_expense_manager/datetime_formatter.dart';
import 'package:ai_expense_manager/expense_model.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense>
    with AutomaticKeepAliveClientMixin {
  String dropdownValue = Constants.list.first;
  final amountController = TextEditingController();
  final dateController = TextEditingController(
      text: MyDateTimeFormatter.getFormattedDateFromDateTime(DateTime.now()));
  String? _amountErrorText;

  void _onCategorySelected(String? value) {
    setState(() {
      dropdownValue = value!;
    });
  }

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      String date =
          MyDateTimeFormatter.getFormattedDateFromDateTime(pickedDate);
      print('date picked = $date');
      dateController.text = date;
    }
  }

  void _onAddExpense() async {
    var expenseAmount = amountController.text;

    setState(() {
      if (expenseAmount.isEmpty) {
        _amountErrorText = 'Please enter amount';
        return;
      }
      _amountErrorText = null;
    });

    ExpenseModel expenseModel = ExpenseModel(
        expenseAmount: int.parse(expenseAmount),
        expenseCategory: Constants.list.indexOf(dropdownValue),
        expenseDateTime: dateController.text);
    print('expenseModel = $expenseModel');

    int insertId = await DatabaseHelper.instance.insert(expenseModel);
    print('data inserted at $insertId');
    _showToast('Expense added');

    amountController.text = '';
  }

  void _showToast(String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: amountController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Enter your expense amount',
                  errorText: _amountErrorText),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              underline: Container(
                height: 1,
                color: Colors.black,
              ),
              onChanged: _onCategorySelected,
              items:
                  Constants.list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: TextFormField(
              controller: dateController,
              onTap: _showDatePicker,
              readOnly: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.calendar_today),
                  labelText: 'Select Date'),
            ),
          ),
          ElevatedButton(
              onPressed: _onAddExpense, child: const Text('Add Expense'))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
