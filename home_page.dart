import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TooltipBehavior _tooltipBehavior;

  // Generate mock data for the graph
  final List<StockData> stockData = List.generate(
    30,
        (index) {
      final date = DateTime.now().subtract(Duration(days: 30 - index));
      final random = Random();
      return StockData(
        date,
          150.0 + random.nextInt(50).toDouble()

      );
    },
  );

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FinX',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            letterSpacing: 2.0,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile_pic.png'), // Replace with actual image path
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hi, Omkar', // Replace with actual account holder name
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_balance, color: Colors.lightBlue),
              title: Text('Accounts'),
              onTap: () {
                Navigator.pushNamed(context, '/account_page');
              },
            ),
            ListTile(
              leading: Icon(Icons.swap_vert, color: Colors.lightBlue),
              title: Text('Transaction'),
              onTap: () {
                Navigator.pushNamed(context, '/transactions_page');
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt_long, color: Colors.lightBlue),
              title: Text('Expenses'),
              onTap: () {
                Navigator.pushNamed(context, '/expenses_page');
              },
            ),
            ListTile(
              leading: Icon(Icons.show_chart, color: Colors.lightBlue),
              title: Text('Personal Investment'),
              onTap: () {
                Navigator.pushNamed(context, '/investment_page');
              },
            ),
            ListTile(
              leading: Icon(Icons.chat, color: Colors.lightBlue),
              title: Text('Chatbot'),
              onTap: () {
                Navigator.pushNamed(context, '/chatbot_page');
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.lightBlue),
              title: Text('Notification'),
              onTap: () {
                Navigator.pushNamed(context, '/notification_page');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.lightBlue),
              title: Text('Setting'),
              onTap: () {
                Navigator.pushNamed(context, '/setting_page');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Balance Container
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Balance',
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '₹ 50,000',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Family and Recent Transactions Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/family_page');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        'Family',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/recent_transaction');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        'Recent Pay',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Interactive Graph
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: SfCartesianChart(
                  title: ChartTitle(text: 'Stock Performance'),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: _tooltipBehavior,
                  primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat.MMMd(),
                    intervalType: DateTimeIntervalType.days,
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                  ),
                  primaryYAxis: NumericAxis(
                    labelFormat: '₹{value}',
                  ),
                  series: <ChartSeries>[
                    LineSeries<StockData, DateTime>(
                      dataSource: stockData,
                      xValueMapper: (StockData stock, _) => stock.date,
                      yValueMapper: (StockData stock, _) => stock.price,
                      name: 'Stock Price',
                      color: Colors.blue,
                      markerSettings: MarkerSettings(isVisible: true),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Top Stocks Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Top Stock',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),

              // List of Top Stocks
              Column(
                children: [
                  _buildStockContainer('Apple', 'AAPL', '\$150.00', '+2.5%', 'assets/apple.png'),
                  SizedBox(height: 10),
                  _buildStockContainer('Google', 'GOOGL', '\$2800.00', '+1.2%', 'assets/google.png'),
                  SizedBox(height: 10),
                  _buildStockContainer('Amazon', 'AMZN', '\$3400.00', '+3.1%', 'assets/amazon.png'),
                  SizedBox(height: 10),
                  _buildStockContainer('Microsoft', 'MSFT', '\$290.00', '+0.8%', 'assets/microsoft.png'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create stock container
  Widget _buildStockContainer(String companyName, String symbol, String price, String percentage, String logoPath) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                logoPath,
                width: 40,
                height: 40,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 40, color: Colors.red);
                },
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(companyName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(symbol, style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(percentage, style: TextStyle(fontSize: 12, color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }
}

// Model class for stock data
class StockData {
  final DateTime date;
  final double price;

  StockData(this.date, this.price);
}
