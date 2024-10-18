import 'package:flutter/material.dart';
import 'expense_chart.dart'; // Adjust the path accordingly
import 'pages/expense_tracker.dart';

void main() => runApp(ExpenseTrackerApp());

class ExpenseTrackerApp extends StatefulWidget {
  @override
  _ExpenseTrackerAppState createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  ThemeMode _themeMode = ThemeMode.system; // Initial theme follows system setting

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
      themeMode: _themeMode, // Use the toggled theme mode
      home: Scaffold(
        appBar: AppBar(
          title: Text('Expense Tracker'),
          leading: IconButton(
            icon: Icon(_themeMode == ThemeMode.light
                ? Icons.nightlight_round // Moon icon for light mode
                : Icons.wb_sunny), // Sun icon for dark mode
            onPressed: _toggleThemeMode, // Toggle theme on button press
          ),
        ),
        body: ExpenseTrackerHome(), // Your home widget
      ),
    );
  }
}