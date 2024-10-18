class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String type; // New field for expense type

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type, // Add this
  });

  // Convert Expense object to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'amount': amount,
    'date': date.toIso8601String(),
    'type': type, // Add this
  };

  // Create Expense object from JSON
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      type: json['type'], // Add this
    );
  }
}