import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final Function deleteExpense;

  ExpenseItem(this.expense, this.deleteExpense);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: ListTile(
        title: Text(expense.title),
        subtitle: Text(
          '\$${expense.amount.toStringAsFixed(2)} on ${expense.date.toLocal().toString().split(' ')[0]}',
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).colorScheme.error,
          onPressed: () => deleteExpense(expense.id),
        ),
      ),
    );
  }
}