import 'package:ai_expense_manager/database.dart';
import 'package:ai_expense_manager/screens/add_expense.dart';
import 'package:ai_expense_manager/screens/dashboard.dart';
import 'package:ai_expense_manager/screens/list_expense.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.instance.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Expense Manager',
      theme: ThemeData(
        //scaffoldBackgroundColor: Colors.blueGrey,
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'AI Expense Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _screens = <Widget>[
    const AddExpense(),
    const ListExpense(),
    const Dashboard()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getScreen() {
    return _screens[_selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Expenses'),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Dashboard',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.cyan,
          onTap: _onItemTapped,
        ),
        floatingActionButton: null);
  }
}
