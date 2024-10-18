import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpensesProvider with ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  double get totalExpenses {
    return _expenses.fold(0.0, (sum, item) => sum + item.amount);
  }
}