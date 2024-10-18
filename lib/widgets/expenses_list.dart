import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final Function deleteExpense;

  ExpensesList(this.expenses, this.deleteExpense);

  @override
  Widget build(BuildContext context) {
    return expenses.isEmpty
        ? Center(
      child: Text('No expenses added yet!'),
    )
        : ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
        return ExpenseItem(expenses[index], deleteExpense);
      },
    );
  }
}