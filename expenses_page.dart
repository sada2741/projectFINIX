import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart'; // Syncfusion package for charts

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  String selectedMonth = 'January'; // Default selected month
  String selectedFamilyMember = 'All Accounts'; // Default selected account

  // Sample data for expenses
  List<ExpenseData> expenses = [
    ExpenseData(category: 'Transportation', date: 'Sept 01, 2024', amount: -300, icon: Icons.directions_car),
    ExpenseData(category: 'Groceries', date: 'Sept 12, 2024', amount: -1000, icon: Icons.shopping_cart),
    ExpenseData(category: 'Utility', date: 'Sept 10, 2024', amount: -3000, icon: Icons.flash_on),
    ExpenseData(category: 'Food', date: 'Sept 14, 2024', amount: -2000, icon: Icons.fastfood),
    ExpenseData(category: 'Subscription', date: 'Sept 15, 2024', amount: -500, icon: Icons.subscriptions),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown for Months and Family Accounts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedMonth,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                    });
                  },
                  items: <String>[
                    'January', 'February', 'March', 'April', 'May', 'June',
                    'July', 'August', 'September', 'October', 'November', 'December'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: selectedFamilyMember,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFamilyMember = newValue!;
                      if (selectedFamilyMember != 'All Accounts') {
                        // Redirect to the specific family member's expense page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FamilyMemberExpensePage(
                              memberName: selectedFamilyMember,
                            ),
                          ),
                        );
                      }
                    });
                  },
                  items: <String>[
                    'All Accounts', 'Ankita Deshmukh', 'Virat Kohli', 'Rohit Sharma', 'KL Rahul'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Graph of Expenses
            Container(
              height: 200,
              child: SfCircularChart(
                legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                series: <CircularSeries>[
                  DoughnutSeries<ExpenseData, String>(
                    dataSource: expenses,
                    xValueMapper: (ExpenseData data, _) => data.category,
                    yValueMapper: (ExpenseData data, _) => data.amount.abs(),
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            // List of Recent Expenses
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(expenses[index].icon, size: 40),
                      title: Text(expenses[index].category),
                      subtitle: Text(expenses[index].date),
                      trailing: Text(
                        '₹${expenses[index].amount.abs().toStringAsFixed(2)}', // Updated to Rupee sign
                        style: TextStyle(color: expenses[index].amount < 0 ? Colors.red : Colors.green),
                      ),
                      onTap: () {
                        // On tap, navigate to details page or show a dialog with more details
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Expense Details'),
                            content: Text('Category: ${expenses[index].category}\n'
                                'Date: ${expenses[index].date}\n'
                                'Amount: ₹${expenses[index].amount.abs().toStringAsFixed(2)}'), // Updated to Rupee sign
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Data model for expenses
class ExpenseData {
  final String category;
  final String date;
  final double amount;
  final IconData icon;

  ExpenseData({required this.category, required this.date, required this.amount, required this.icon});
}

// Family Member Expense Page
class FamilyMemberExpensePage extends StatelessWidget {
  final String memberName;

  FamilyMemberExpensePage({required this.memberName});

  // Sample data for family member's expenses
  final List<ExpenseData> familyMemberExpenses = [
    ExpenseData(category: 'Books', date: 'Sept 05, 2024', amount: -700, icon: Icons.book),
    ExpenseData(category: 'Cinema', date: 'Sept 08, 2024', amount: -400, icon: Icons.movie),
    ExpenseData(category: 'Medicine', date: 'Sept 11, 2024', amount: -300, icon: Icons.local_hospital),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$memberName Expenses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Graph of Family Member's Expenses
            Container(
              height: 200,
              child: SfCircularChart(
                legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                series: <CircularSeries>[
                  DoughnutSeries<ExpenseData, String>(
                    dataSource: familyMemberExpenses,
                    xValueMapper: (ExpenseData data, _) => data.category,
                    yValueMapper: (ExpenseData data, _) => data.amount.abs(),
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            // List of Family Member's Recent Expenses
            Expanded(
              child: ListView.builder(
                itemCount: familyMemberExpenses.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(familyMemberExpenses[index].icon, size: 40),
                      title: Text(familyMemberExpenses[index].category),
                      subtitle: Text(familyMemberExpenses[index].date),
                      trailing: Text(
                        '₹${familyMemberExpenses[index].amount.abs().toStringAsFixed(2)}', // Updated to Rupee sign
                        style: TextStyle(color: familyMemberExpenses[index].amount < 0 ? Colors.red : Colors.green),
                      ),
                      onTap: () {
                        // On tap, show a dialog with more details
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Expense Details'),
                            content: Text('Category: ${familyMemberExpenses[index].category}\n'
                                'Date: ${familyMemberExpenses[index].date}\n'
                                'Amount: ₹${familyMemberExpenses[index].amount.abs().toStringAsFixed(2)}'), // Updated to Rupee sign
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
