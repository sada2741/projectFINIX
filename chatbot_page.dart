import 'package:flutter/material.dart';

class ChatbotPage  extends StatefulWidget {
  @override
  _FinancialChatbotState createState() => _FinancialChatbotState();
}

class _FinancialChatbotState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final List<Map<String, dynamic>> _qaDatabase = [
    // Basic Account Queries
    {
      "question": ["How do I create an account?", "sign up process"],
      "answer": "To create an account: 1) Download app 2) Enter email/phone 3) Create password 4) Verify identity 5) Link bank accounts 6) Complete profile"
    },
    {
      "question": ["How secure is my financial data?", "data protection"],
      "answer": "We use bank-grade encryption, multi-factor authentication, secure cloud storage, and regular security audits to protect your financial information."
    },
    {
      "question": ["Can I use the app for multiple family members?", "family account"],
      "answer": "Yes, you can create a family account with different access levels: Primary user, Spouse, Children, with customizable permissions and visibility."
    },
    {
      "question": ["What devices are supported?", "app compatibility"],
      "answer": "Our app supports iOS (12+), Android (8+), web browsers, and offers synchronized data across all platforms."
    },
    {
      "question": ["How often is my financial data updated?", "data sync"],
      "answer": "Financial data updates in real-time, with bank account information refreshed every 15 minutes during business hours."
    },

    // BANKING & ACCOUNTS
    {
      "question": ["How do I link my bank account?", "account connection"],
      "answer": "Link bank account: 1) Go to 'Accounts' 2) Select 'Add Bank' 3) Choose your bank 4) Enter credentials securely 5) Verify connection"
    },
    {
      "question": ["What bank accounts can I track?", "supported banks"],
      "answer": "We support major banks including: Chase, Bank of America, Wells Fargo, Citibank, Credit Unions, and most national and regional banks."
    },
    {
      "question": ["Can I track credit card expenses?", "credit tracking"],
      "answer": "Yes, you can link and track multiple credit cards, with automatic expense categorization and spending insights."
    },
    {
      "question": ["How accurate is expense tracking?", "expense accuracy"],
      "answer": "Our AI-powered tracking is 95% accurate, with machine learning continuously improving categorization and expense recognition."
    },
    {
      "question": ["Can I manually add transactions?", "transaction entry"],
      "answer": "Yes, you can manually add cash transactions, checks, and other expenses not automatically detected by linked accounts."
    },

    // INVESTMENT FEATURES
    {
      "question": ["How do investment recommendations work?", "investment advice"],
      "answer": "Our AI analyzes your financial profile, risk tolerance, market trends, and personal goals to provide personalized investment recommendations."
    },
    {
      "question": ["What investment types can I track?", "investment options"],
      "answer": "Track stocks, mutual funds, ETFs, bonds, cryptocurrencies, retirement accounts, and real estate investments in one platform."
    },
    {
      "question": ["How often are stock prices updated?", "stock tracking"],
      "answer": "Stock prices update in real-time during market hours, with 15-minute delayed quotes for after-hours trading."
    },
    {
      "question": ["Can I simulate investment scenarios?", "investment simulation"],
      "answer": "Our app offers investment scenario simulation to test strategies, predict outcomes, and learn risk-free investment approaches."
    },
    {
      "question": ["Do you provide international stock tracking?", "global markets"],
      "answer": "Yes, track stocks from major global exchanges including NYSE, NASDAQ, London, Tokyo, Hong Kong, and European markets."
    },

    // BUDGETING & EXPENSES
    {
      "question": ["How does budget creation work?", "budget setup"],
      "answer": "Create budgets by: 1) Setting income 2) Categorizing expenses 3) Setting spending limits 4) Receiving real-time alerts 5) Tracking progress"
    },
    {
      "question": ["Can the app help reduce expenses?", "expense reduction"],
      "answer": "Our AI provides personalized expense reduction strategies, identifies unnecessary subscriptions, and suggests cost-saving opportunities."
    },
    {
      "question": ["How are expenses categorized?", "expense categories"],
      "answer": "Automatic categories include: Groceries, Dining, Transportation, Utilities, Entertainment, Shopping, Healthcare, Education, Subscriptions."
    },
    {
      "question": ["Can I set savings goals?", "goal tracking"],
      "answer": "Set multiple savings goals, track progress, receive recommendations, and get motivational insights to help you achieve financial targets."
    },
    {
      "question": ["What is bill tracking?", "bill management"],
      "answer": "Track all bills, receive payment reminders, predict upcoming expenses, and get notifications to avoid late fees."
    },

    // RETIREMENT & LONG-TERM PLANNING
    {
      "question": ["How can I plan for retirement?", "retirement strategy"],
      "answer": "Our retirement planning includes: 1) Retirement calculator 2) Goal tracking 3) Investment recommendations 4) Social Security analysis 5) Tax optimization"
    },
    {
      "question": ["Can I track 401k and IRA?", "retirement accounts"],
      "answer": "Easily track and analyze 401k, Traditional IRA, Roth IRA, and other retirement accounts with comprehensive performance insights."
    },
    {
      "question": ["What retirement advice do you offer?", "retirement guidance"],
      "answer": "Personalized retirement guidance based on age, income, current savings, risk tolerance, and projected retirement lifestyle."
    },

    // RISK & PORTFOLIO MANAGEMENT
    {
      "question": ["How do you assess investment risk?", "risk assessment"],
      "answer": "Risk assessment includes: Portfolio volatility, diversification analysis, personal risk tolerance questionnaire, market condition evaluation."
    },
    {
      "question": ["What is portfolio diversification?", "investment diversity"],
      "answer": "Diversification strategies across asset classes, sectors, geographies to minimize risk and optimize potential returns."
    },

    // ADVANCED AI & MACHINE LEARNING
    {
      "question": ["How does AI recommend investments?", "AI investment"],
      "answer": "Our AI uses machine learning to analyze personal financial data, market trends, historical performance, and individual risk profiles."
    },
    {
      "question": ["Can AI predict market trends?", "market prediction"],
      "answer": "AI provides trend insights, not guaranteed predictions, by analyzing historical data, economic indicators, and market sentiment."
    },

    // ADDITIONAL SPECIALIZED QUERIES
    {
      "question": ["How to handle joint finances?", "couple finances"],
      "answer": "Joint finance features: Shared view, individual privacy, collaborative budgeting, synchronized financial goals, transparent spending tracking."
    },
    {
      "question": ["Can teenagers use the app?", "youth financial tools"],
      "answer": "Parental control features allow teenagers to learn financial management with restricted, educational access and spending limits."
    },

    // Investment Strategies
    {
      "question": ["What are the best investment strategies?", "investment strategies"],
      "answer": "Top investment strategies include: 1) Dollar-cost averaging 2) Index fund investing 3) Diversification 4) Long-term growth 5) Value investing 6) Growth investing 7) Dividend investing"
    },
    {
      "question": ["How much money should I invest?", "investment amount"],
      "answer": "Investment amount depends on: 1) Income 2) Financial goals 3) Risk tolerance 4) Emergency fund status. A common rule is 10-15% of monthly income, but start with what you're comfortable with."
    },
    {
      "question": ["What's the minimum amount to start investing?", "minimum investment"],
      "answer": "Many platforms allow investing with as little as 5-50. Our app supports micro-investing, letting you start small and gradually increase your investments."
    },
    {
      "question": ["Can you explain different types of investments?", "investment types"],
      "answer": "Investment types include: 1) Stocks 2) Bonds 3) Mutual Funds 4) ETFs 5) Real Estate 6) Cryptocurrencies 7) Certificates of Deposit 8) Retirement Accounts"
    },

    // Stock-Specific Queries
    {
      "question": ["Which stocks should I buy?", "stock recommendations"],
      "answer": "Stock recommendations are personalized based on your: 1) Risk profile 2) Financial goals 3) Investment horizon 4) Current market conditions. Our AI analyzes these factors to suggest suitable stocks."
    },
    {
      "question": ["How are my current stocks performing?", "stock performance"],
      "answer": "Stock performance tracking is available in the Investments section. We provide real-time updates, performance graphs, comparative analysis, and historical trends."
    },
    {
      "question": ["What are high-growth potential stocks?", "growth stocks"],
      "answer": "High-growth potential stocks are typically in technology, healthcare, and emerging markets. Our app uses AI to identify stocks with strong growth indicators."
    },
    {
      "question": ["Can you recommend stocks for beginners?", "beginner stock investments"],
      "answer": "Beginner-friendly stocks: 1) Blue-chip stocks 2) Index funds 3) ETFs 4) Large-cap stable companies 5) Dividend-paying stocks. Focus on low-risk, diversified investments."
    },
    {
      "question": ["How do I analyze a stock before investing?", "stock analysis"],
      "answer": "Stock analysis involves: 1) Company financials 2) Price-to-earnings ratio 3) Earnings growth 4) Market position 5) Industry trends 6) Management quality 7) Competitive landscape"
    },
    {
      "question": ["What's the current market trend?", "market trends"],
      "answer": "Market trends are dynamic. Our app provides real-time market analysis, including sector performance, economic indicators, and potential investment opportunities."
    },
    {
      "question": ["How do I track stock performance?", "stock tracking"],
      "answer": "Track stock performance through: 1) Real-time price updates 2) Historical charts 3) Comparative analysis 4) Performance metrics 5) News and event tracking"
    },

    // Portfolio Management
    {
      "question": ["How do I create an investment portfolio?", "portfolio creation"],
      "answer": "Create an investment portfolio by: 1) Defining financial goals 2) Assessing risk tolerance 3) Choosing asset allocation 4) Selecting diverse investments 5) Regular rebalancing"
    },
    {
      "question": ["Can you help me diversify my investments?", "investment diversification"],
      "answer": "Diversification strategies: 1) Spread across asset classes 2) Mix domestic and international stocks 3) Combine stocks, bonds, ETFs 4) Include different sectors 5) Regular portfolio review"
    },
    {
      "question": ["What's the risk level of my current portfolio?", "portfolio risk"],
      "answer": "Portfolio risk is calculated based on: 1) Asset allocation 2) Investment types 3) Market volatility 4) Individual stock performance 5) Economic indicators"
    },
    {
      "question": ["How often should I rebalance my portfolio?", "portfolio rebalancing"],
      "answer": "Recommended portfolio rebalancing: 1) Annually 2) When asset allocation shifts >5% 3) After major life changes 4) During significant market shifts"
    },
    {
      "question": ["Can you suggest portfolio allocation?", "portfolio allocation"],
      "answer": "Portfolio allocation depends on: 1) Age 2) Risk tolerance 3) Financial goals. Typical allocations: Young investors (80-90% stocks), Middle-age (60-70% stocks), Near retirement (40-50% stocks)"
    },

    // Investment Analysis
    {
      "question": ["What's the projected return on my investments?", "investment returns"],
      "answer": "Investment return projections consider: 1) Historical performance 2) Market conditions 3) Asset allocation 4) Economic forecasts 5) Individual investment characteristics"
    },
    {
      "question": ["How do I calculate potential investment gains?", "investment gains"],
      "answer": "Calculate investment gains by: 1) Initial investment amount 2) Expected annual return rate 3) Investment duration 4) Compound interest calculation 5) Risk considerations"
    },
    {
      "question": ["Can you compare different investment options?", "investment comparison"],
      "answer": "Our app provides comprehensive investment comparisons including: 1) Performance metrics 2) Risk levels 3) Fees 4) Historical returns 5) Future potential 6) Sector analysis"
    },
    {
      "question": ["What are the fees associated with investing?", "investment fees"],
      "answer": "Common investment fees: 1) Trading commissions 2) Management fees 3) Expense ratios 4) Performance fees 5) Account maintenance fees"
    },
    {
      "question": ["How do market conditions affect my investments?", "market impact"],
      "answer": "Market conditions impact investments through: 1) Economic indicators 2) Interest rates 3) Global events 4) Sector performance 5) Investor sentiment 6) Technological changes"
    },

    // Technical Investment Features
    {
      "question": ["How do I link my brokerage account?", "brokerage account link"],
      "answer": "Link brokerage account: 1) Go to 'Accounts' section 2) Select 'Link Brokerage' 3) Choose your broker 4) Enter credentials securely 5) Authorize data access"
    },
    {
      "question": ["Can I simulate investment scenarios?", "investment simulation"],
      "answer": "Our app offers investment scenario simulation: 1) Test different strategies 2) Predict potential outcomes 3) Compare investment approaches 4) Risk-free learning environment"
    },
    {
      "question": ["How does the app calculate investment recommendations?", "investment recommendation algorithm"],
      "answer": "Investment recommendations use AI algorithms considering: 1) Personal financial data 2) Risk profile 3) Market trends 4) Historical performance 5) Machine learning models"
    },
    {
      "question": ["What data sources does the app use?", "investment data sources"],
      "answer": "Data sources include: 1) Stock exchanges 2) Financial news networks 3) Economic databases 4) Government financial reports 5) Real-time market feeds"
    },
    {
      "question": ["Can I set investment alerts?", "investment notifications"],
      "answer": "Investment alerts include: 1) Price changes 2) Portfolio performance 3) Market trends 4) Recommended actions 5) Potential investment opportunities"
    },

    // App-Specific Investment Queries
    {
      "question": ["How does your AI recommend investments?", "AI investment recommendations"],
      "answer": "Our AI uses advanced machine learning to analyze: 1) Your financial profile 2) Risk tolerance 3) Market trends 4) Historical data 5) Personalized investment strategies"
    },
    {
      "question": ["Can the app track international stocks?", "international stock tracking"],
      "answer": "Yes, our app supports international stock tracking across multiple global exchanges and markets."
    },
    {
      "question": ["Do you provide real-time stock updates?", "real-time stock information"],
      "answer": "Real-time stock updates include: 1) Live price tracking 2) Market movement 3) Trading volume 4) Significant news 5) Instant notifications"
    },
    {
      "question": ["How secure is my investment data?", "data security"],
      "answer": "Investment data security features: 1) Bank-level encryption 2) Multi-factor authentication 3) Regular security audits 4) Secure cloud storage 5) Compliance with financial regulations"
    },
    {
      "question": ["Can family members share investment insights?", "family investment sharing"],
      "answer": "Family investment features: 1) Shared portfolio view 2) Collaborative insights 3) Individual privacy controls 4) Separate access levels 5) Consolidated family financial planning"
    },
    {
      "question": ["How much money is in my bank account?", "bank balance"],
      "answer": "To check your current bank balance, please log in to your banking app or contact customer support. For security reasons, I cannot directly access your account details."
    },
    {
      "question": ["What accounts do I have?", "list of accounts"],
      "answer": "Your accounts typically include: Checking Account, Savings Account, and Investment Account. For a detailed breakdown, please check your bank statements or online banking portal."
    },

    // Investment Queries
    {
      "question": ["What is a good investment strategy?", "how to invest"],
      "answer": "A good investment strategy depends on your age, income, risk tolerance, and financial goals. Generally, consider: 1) Diversification 2) Long-term investing 3) Regular contributions 4) Low-cost index funds 5) Emergency fund"
    },
    {
      "question": ["Should I invest in stocks?", "stock market investing"],
      "answer": "Stock investing requires careful research. Consider your risk tolerance, diversify your portfolio, start with index funds, and never invest money you can't afford to lose. Consult a financial advisor for personalized advice."
    },
    {
      "question": ["What is mutual fund?", "mutual fund explanation"],
      "answer": "A mutual fund is an investment vehicle that pools money from multiple investors to invest in stocks, bonds, or other securities. It offers diversification, professional management, and is suitable for investors who want less direct market involvement."
    },

    // Savings and Budgeting
    {
      "question": ["How to save money?", "saving tips"],
      "answer": "Saving money tips: 1) Create a budget 2) Track expenses 3) Cut unnecessary subscriptions 4) Use 50/30/20 rule 5) Automate savings 6) Create emergency fund 7) Reduce high-interest debt"
    },
    {
      "question": ["What is emergency fund?", "emergency savings"],
      "answer": "An emergency fund is savings set aside to cover unexpected expenses like medical emergencies, job loss, or major repairs. Aim to save 3-6 months of living expenses in an easily accessible account."
    },

    // Retirement Planning
    {
      "question": ["How to plan for retirement?", "retirement savings"],
      "answer": "Retirement planning steps: 1) Start early 2) Contribute to 401(k) or IRA 3) Take advantage of employer match 4) Diversify investments 5) Increase contributions with salary raises 6) Consider long-term growth"
    },
    {
      "question": ["When should I start saving for retirement?", "retirement age"],
      "answer": "The best time to start saving for retirement is now! Ideally, start in your 20s, but it's never too late. The earlier you start, the more you benefit from compound interest."
    },

    // Debt Management
    {
      "question": ["How to manage debt?", "debt reduction"],
      "answer": "Debt management strategies: 1) List all debts 2) Prioritize high-interest debt 3) Use debt avalanche or snowball method 4) Negotiate lower interest rates 5) Consider debt consolidation 6) Avoid taking new debt"
    },

    // Investment Types
    {
      "question": ["What are bonds?", "bond investment"],
      "answer": "Bonds are fixed-income investments where you lend money to a government or company in exchange for periodic interest payments and return of principal at maturity. Generally considered lower risk compared to stocks."
    },
    {
      "question": ["What is cryptocurrency?", "crypto investing"],
      "answer": "Cryptocurrency is a digital or virtual currency using blockchain technology. It's highly volatile and speculative. Only invest what you can afford to lose, and thoroughly research before investing."
    },

    // Risk Assessment
    {
      "question": ["What is risk tolerance?", "investment risk"],
      "answer": "Risk tolerance is your ability and willingness to lose some or all of an investment in exchange for potential greater returns. It varies based on age, financial situation, and personal comfort with market fluctuations."
    },

    // Insurance
    {
      "question": ["Do I need insurance?", "types of insurance"],
      "answer": "Essential insurance types: 1) Health Insurance 2) Life Insurance 3) Disability Insurance 4) Homeowners/Renters Insurance 5) Auto Insurance. Coverage depends on your personal circumstances."
    },

    // Tax Planning
    {
      "question": ["How to reduce taxes?", "tax saving strategies"],
      "answer": "Tax saving strategies: 1) Maximize retirement account contributions 2) Use tax-advantaged accounts 3) Harvest tax losses 4) Claim all eligible deductions 5) Consider municipal bonds 6) Consult a tax professional"
    },
    {
      "question": ["How much money do I have in my account?", "account balance"],
      "answer": "To get real-time account balance, you'll need to link your bank accounts in the app settings. For security reasons, I can't directly access your exact balance."
    },
    {
      "question": ["What are my recent transactions?", "transaction history"],
      "answer": "Recent transactions can be viewed in the Transactions section of the app. We categorize and track all your spending automatically for easy review."
    },
    {
      "question": ["How much did I spend last month?", "monthly spending"],
      "answer": "Monthly spending analysis is available in the Expenses section. We break down your expenses by category to help you understand your spending patterns."
    },
    {
      "question": ["What is the total balance across all my accounts?", "total account balance"],
      "answer": "The Total Balance feature in the app aggregates balances from all linked accounts, giving you a comprehensive financial overview."
    },

    // Investment Expansion
    {
      "question": ["What are the best investment options for me?", "investment recommendations"],
      "answer": "Investment recommendations are personalized based on your financial profile, risk tolerance, and goals. Our AI analyzes your data to suggest tailored investment strategies."
    },
    {
      "question": ["How is my stock portfolio performing?", "portfolio performance"],
      "answer": "Portfolio performance tracking is available in the Investments section. We provide real-time updates, performance graphs, and comparative analysis."
    },
    {
      "question": ["How do I diversify my investment portfolio?", "portfolio diversification"],
      "answer": "Diversification strategies include: 1) Spread investments across different asset classes 2) Mix stocks, bonds, and ETFs 3) Consider international markets 4) Rebalance periodically"
    },

    // Family Financial Management
    {
      "question": ["Can you recommend savings goals for our family?", "family savings plan"],
      "answer": "Family savings goals depend on your specific circumstances. We recommend: 1) Emergency fund 2) Education savings 3) Retirement 4) Major purchases 5) Vacation fund"
    },
    {
      "question": ["What are the combined expenses of the family?", "total family expenses"],
      "answer": "Family expense tracking is a key feature. We aggregate expenses from all linked family accounts, providing a comprehensive view of total household spending."
    },
    {
      "question": ["How do I connect my bank account to the app?", "account linking"],
      "answer": "To link a bank account: 1) Go to Settings 2) Select 'Link Account' 3) Choose your bank 4) Securely authenticate 5) Select accounts to track"
    },

    // Expense Analysis
    {
      "question": ["What is my spending analysis for this month?", "monthly spending breakdown"],
      "answer": "Monthly spending analysis includes: 1) Expense categories 2) Spending trends 3) Budget comparisons 4) Potential savings opportunities"
    },
    {
      "question": ["Can you categorize my expenses?", "expense categorization"],
      "answer": "We automatically categorize expenses into: 1) Groceries 2) Dining 3) Transportation 4) Utilities 5) Entertainment 6) Shopping 7) Healthcare"
    },

    // Future Planning
    {
      "question": ["How can I save for my child's education?", "education savings"],
      "answer": "Education savings strategies: 1) 529 College Savings Plan 2) Consistent monthly contributions 3) Consider growth-oriented investments 4) Start early"
    },
    {
      "question": ["Can you help me set a savings goal?", "savings goal setting"],
      "answer": "To set a savings goal: 1) Determine target amount 2) Set timeline 3) Calculate monthly contribution needed 4) Track progress 5) Adjust as needed"
    },

    // Notifications and Alerts
    {
      "question": ["Do I have any pending bills?", "bill reminders"],
      "answer": "Bill tracking is a key app feature. We send notifications for upcoming bills, potential late fees, and suggest optimal payment timing."
    },
    {
      "question": ["Can you notify me about investment opportunities?", "investment alerts"],
      "answer": "Investment alerts include: 1) Market trend notifications 2) Portfolio performance updates 3) Potential investment opportunities 4) Risk level changes"
    },

  ];

  void _handleMessage(String message) {
    setState(() {
      _messages.add({"sender": "user", "text": message});

      // Find the best matching answer
      String bestAnswer = _findBestAnswer(message);

      _messages.add({"sender": "bot", "text": bestAnswer});
    });
    _messageController.clear();
  }

  String _findBestAnswer(String userQuery) {
    userQuery = userQuery.toLowerCase();

    // Find exact or close match
    for (var qa in _qaDatabase) {
      for (var question in qa['question']) {
        if (userQuery.contains(question.toLowerCase())) {
          return qa['answer'];
        }
      }
    }

    // Fallback response
    return "I'm not sure about that specific query. Could you rephrase or ask something more general about finances?";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Financial Advisor Chatbot'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, String> message) {
    bool isUser = message['sender'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[100] : Colors.green[100],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message['text'] ?? '',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Ask a financial question...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: () => _handleMessage(_messageController.text),
            ),
          ),
        ],
      ),
    );
  }
}