import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TransactionsPage(),
    );
  }
}

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final List<Map<String, dynamic>> familyAccounts = [
    {
      'name': 'Ankita Deshmukh',
      'accounts': [
        {'bank': 'Bank A', 'accountType': 'Savings', 'balance': '₹15,000'},
        {'bank': 'Bank B', 'accountType': 'Checking', 'balance': '₹5,000'},
      ],
    },
    {
      'name': 'Virat Kohli',
      'accounts': [
        {'bank': 'Bank C', 'accountType': 'Savings', 'balance': '₹25,000'},
      ],
    },
  ];

  String? selectedFamilyMember;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Transactions'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
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
            ElevatedButton(
              onPressed: () {
                // Implement projected cash flow functionality here
              },
              child: Text('See projected cash flow'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.lightBlue[100],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Recent Activity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Showing All Transactions',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('Select Family Member'),
              value: selectedFamilyMember,
              onChanged: (String? newValue) {
                setState(() {
                  selectedFamilyMember = newValue;
                });
                if (newValue != null) {
                  _showFamilyMemberTransactions(context, newValue);
                }
              },
              items: familyAccounts.map<DropdownMenuItem<String>>((member) {
                return DropdownMenuItem<String>(
                  value: member['name'] as String,
                  child: Text(member['name'] as String),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search transactions',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Opening Balance'),
              subtitle: Text('Balance Adjustment'),
              trailing: Text(
                '+₹500.00',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                // Implement transaction details functionality here
              },
            ),
            SizedBox(height: 5),
            Text(
              'Jan 4, 2024',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  void _showFamilyMemberTransactions(BuildContext context, String memberName) {
    final member = familyAccounts.firstWhere((m) => m['name'] == memberName);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FamilyMemberTransactionsPage(member: member),
      ),
    );
  }

  void _showDateRangePicker(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.purple,
            hintColor: Colors.purple,
            colorScheme: ColorScheme.light(primary: Colors.purple),
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

class FamilyMemberTransactionsPage extends StatelessWidget {
  final Map<String, dynamic> member;

  FamilyMemberTransactionsPage({required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${member['name']}\'s Transactions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: (member['accounts'] as List<Map<String, dynamic>>).map<Widget>((account) {
            return ListTile(
              leading: Icon(Icons.account_balance_wallet, color: Colors.blue),
              title: Text('${account['bank']} (${account['accountType']})'),
              subtitle: Text('Balance: ${account['balance']}'),
            );
          }).toList(),
        ),
      ),
    );
  }
}
