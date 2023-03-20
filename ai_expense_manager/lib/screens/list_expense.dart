import 'package:flutter/material.dart';

class ListExpense extends StatefulWidget {
  const ListExpense({super.key});

  @override
  State<ListExpense> createState() => _ListExpenseState();
}

class _ListExpenseState extends State<ListExpense> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('List of expenses'));
  }
}
