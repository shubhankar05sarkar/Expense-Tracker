import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';


class ExpenseChart extends StatelessWidget {
  final List<Expense> expenses;

  ExpenseChart(this.expenses);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PieChart(
        PieChartData(
          sections: _buildChartSections(),
          borderData: FlBorderData(show: false),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildChartSections() {
    Map<String, double> categoryTotals = {};

    for (var expense in expenses) {
      if (categoryTotals.containsKey(expense.type)) {
        categoryTotals[expense.type] = categoryTotals[expense.type]! + expense.amount;
      } else {
        categoryTotals[expense.type] = expense.amount;
      }
    }

    return categoryTotals.entries.map((entry) {
      return PieChartSectionData(
        color: _getCategoryColor(entry.key),
        value: entry.value,
        title: '${entry.key}: \$${entry.value.toStringAsFixed(2)}',
        radius: 50,
      );
    }).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.red;
      case 'Transport':
        return Colors.blue;
      case 'Utilities':
        return Colors.green;
      case 'Entertainment':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
