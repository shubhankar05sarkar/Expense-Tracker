import 'package:flutter/material.dart';
import 'expense_chart.dart';
import 'pages/expense_tracker.dart';

void main() => runApp(ExpenseTrackerApp());

class ExpenseTrackerApp extends StatefulWidget {
  @override
  _ExpenseTrackerAppState createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleThemeMode() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Expense Tracker'),
          leading: IconButton(
            icon: Icon(_themeMode == ThemeMode.light
                ? Icons.nightlight_round
                : Icons.wb_sunny),
            onPressed: _toggleThemeMode,
          ),
        ),
        body: ExpenseTrackerHome(),
      ),
    );
  }
}