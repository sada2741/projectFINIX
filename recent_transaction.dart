import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart'; // Import Syncfusion for charts

class RecentTransactionsPage extends StatefulWidget {
  @override
  _RecentTransactionsPageState createState() => _RecentTransactionsPageState();
}

class _RecentTransactionsPageState extends State<RecentTransactionsPage> {
  final List<Map<String, dynamic>> familyAccounts = [
    {
      'name': 'Ankita Deshmukh',
      'transactions': [
        {'description': 'Netflix Subscription', 'icon': 'assets/netflix.png', 'amount': '₹499.00'},
        {'description': 'YouTube Premium', 'icon': 'assets/youtube.png', 'amount': '₹129.00'},
        {'description': 'Amazon Shopping', 'icon': 'assets/amazon.png', 'amount': '₹1500.00'},
      ],
    },
    {
      'name': 'Virat Kohli',
      'transactions': [
        {'description': 'Grocery Store', 'icon': 'assets/grocery.png', 'amount': '₹1200.00'},
        {'description': 'Online Course', 'icon': 'assets/course.png', 'amount': '₹2000.00'},
      ],
    },
  ];

  String? selectedFamilyMember;
  String currentUser = 'Ankita Deshmukh'; // Simulating logged-in user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Transactions'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              _showDateRangePicker(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              hint: Text('Select Family Member'),
              value: selectedFamilyMember,
              onChanged: (String? newValue) {
                setState(() {
                  selectedFamilyMember = newValue;
                });
              },
              items: familyAccounts.map<DropdownMenuItem<String>>((member) {
                return DropdownMenuItem<String>(
                  value: member['name'] as String,
                  child: Text(member['name'] as String),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Donut Chart Section
            _buildDonutChartSection(),
            SizedBox(height: 20),
            // Recent Spending List
            _buildRecentSpendingSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDonutChartSection() {
    List<Map<String, dynamic>> transactions = _getSelectedUserTransactions();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expense Analytics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto', // Example font family
            ),
          ),
          SizedBox(height: 8),
          // Donut Chart for analytics
          Container(
            height: 200,
            child: SfCircularChart(
              legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                textStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto', // Example font family
                ),
              ),
              series: <CircularSeries>[
                DoughnutSeries<Map<String, dynamic>, String>(
                  dataSource: transactions,
                  xValueMapper: (Map<String, dynamic> transaction, _) =>
                  transaction['description'],
                  yValueMapper: (Map<String, dynamic> transaction, _) =>
                      double.parse(transaction['amount'].substring(1).replaceAll(',', '')),
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto', // Example font family
                    ),
                  ),
                  pointColorMapper: (Map<String, dynamic> transaction, _) {
                    // Define custom colors for each transaction type
                    if (transaction['description'] == 'Netflix Subscription') {
                      return Colors.redAccent;
                    } else if (transaction['description'] == 'YouTube Premium') {
                      return Colors.blueAccent;
                    } else if (transaction['description'] == 'Amazon Shopping') {
                      return Colors.orangeAccent;
                    } else {
                      return Colors.greenAccent; // Default color
                    }
                  },
                  explode: true,
                  explodeIndex: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSpendingSection() {
    List<Map<String, dynamic>> transactions = _getSelectedUserTransactions();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Spending',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto', // Example font family
            ),
          ),
          SizedBox(height: 8),
          Column(
            children: transactions.map<Widget>((transaction) {
              return GestureDetector(
                onTap: () {
                  // Show more details on tap
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Transaction Details'),
                      content: Text('Description: ${transaction['description']}\n'
                          'Amount: ${transaction['amount']}'),
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
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(transaction['icon']),
                      radius: 20,
                    ),
                    title: Text(transaction['description']),
                    trailing: Text(
                      transaction['amount'],
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Roboto', // Example font family
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getSelectedUserTransactions() {
    // Fetch transactions for the current user or selected family member
    if (selectedFamilyMember != null) {
      return familyAccounts
          .firstWhere((member) => member['name'] == selectedFamilyMember)['transactions'];
    } else {
      return familyAccounts
          .firstWhere((member) => member['name'] == currentUser)['transactions'];
    }
  }

  void _showDateRangePicker(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            hintColor: Colors.blue,
            colorScheme: ColorScheme.light(primary: Colors.blue),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      print('Picked date range: ${picked.start} - ${picked.end}');
    }
  }
}
