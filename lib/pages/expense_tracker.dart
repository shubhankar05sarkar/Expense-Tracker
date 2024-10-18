import 'package:flutter/material.dart';
import '../widgets/expenses_list.dart';
import '../widgets/new_expense.dart';
import '../models/expense.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../expense_chart.dart';


class ExpenseTrackerHome extends StatefulWidget {
  @override
  _ExpenseTrackerHomeState createState() => _ExpenseTrackerHomeState();
}

class _ExpenseTrackerHomeState extends State<ExpenseTrackerHome> {
  List<Expense> _userExpenses = [];
  String _selectedFilterType = 'All';

  @override
  void initState() {
    super.initState();
    _loadExpensesFromStorage();
  }

  Future<void> _loadExpensesFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedExpenses = prefs.getString('userExpenses');
    if (savedExpenses != null) {
      final List decodedExpenses = json.decode(savedExpenses);
      setState(() {
        _userExpenses = decodedExpenses
            .map((item) => Expense.fromJson(item))
            .toList();
      });
    }
  }

  Future<void> _saveExpensesToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userExpenses', json.encode(_userExpenses));
  }

  void _addNewExpense(String title, double amount, DateTime chosenDate,
      String type) {
    final newExpense = Expense(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
      type: type,
    );

    setState(() {
      _userExpenses.add(newExpense);
    });
    _saveExpensesToStorage();
  }

  void _filterExpensesByType(String type) {
    setState(() {
      _selectedFilterType = type;
    });
  }

  void _deleteExpense(String id) {
    setState(() {
      _userExpenses.removeWhere((expense) => expense.id == id);
    });
    _saveExpensesToStorage();
  }

  void _startAddNewExpense(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewExpense(_addNewExpense);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalExpenses = _userExpenses.fold(
        0.0, (sum, item) => sum + item.amount);

    final filteredExpenses = _selectedFilterType == 'All'
        ? _userExpenses
        : _userExpenses.where((expense) => expense.type == _selectedFilterType)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewExpense(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Total Expenses: \$${totalExpenses.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: _selectedFilterType,
                onChanged: (newValue) {
                  _filterExpensesByType(newValue!);
                },
                items: <String>[
                  'All',
                  'Food',
                  'Transport',
                  'Utilities',
                  'Entertainment'
                ]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              height: 250,
              child: ExpenseChart(
                  filteredExpenses),
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.5,
              child: ExpensesList(filteredExpenses, _deleteExpense),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewExpense(context),
      ),
    );
  }
}