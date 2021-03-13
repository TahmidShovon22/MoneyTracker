import 'package:MoneyTracker/Models/transaction.dart';
import 'package:MoneyTracker/Widgets/new_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './Widgets/transaction_list.dart';
import './Widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Tracker',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNew),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  final List<Transaction> _transaction = [
    Transaction(
      DateTime.now().toString(),
      'Burger',
      'Expense',
      50,
      DateTime.now(),
    ),
    Transaction(
      DateTime.now().toString(),
      'Salary',
      'Income',
      1000,
      DateTime.now(),
    ),
    Transaction(
      DateTime.now().toString(),
      'Rent',
      'Expense',
      10000,
      DateTime.now(),
    ),
    Transaction(
      DateTime.now().toString(),
      'Sell',
      'Income',
      2000,
      DateTime.parse('2020-12-09'),
    ),
  ];

  void _addNew(String title, String type, int amount, DateTime date) {
    final newTransaction = Transaction(
      DateTime.now().toString(),
      title,
      type,
      amount,
      date,
    );
    setState(() {
      _transaction.add(newTransaction);
    });
  }

  void _delete(String id) {
    setState(() {
      _transaction.removeWhere((element) => element.trans_id == id);
    });
  }

  List<Transaction> get _recentTransaction {
    return _transaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  List<Widget> _buildLandscape(MediaQueryData mediaQuery, AppBar appBar) {
    return [
      Container(
        padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top -
                mediaQuery.padding.bottom) *
            0.15,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Show Chart',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold),
            ),
            Switch(
              activeColor: Colors.blue,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              },
            ),
          ],
        ),
      ),
      _showChart
          ? Container(
              padding: EdgeInsets.all(10),
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top -
                      mediaQuery.padding.bottom) *
                  0.85,
              child: Chart(_recentTransaction),
            )
          : Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top -
                      mediaQuery.padding.bottom) *
                  0.7,
              child: TransactionList(_transaction, _delete),
            )
    ];
  }

  Widget _buildPortrait(MediaQueryData mediaQuery, AppBar appBar) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top -
                  mediaQuery.padding.bottom) *
              0.3,
          child: Chart(_recentTransaction),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top -
                  mediaQuery.padding.bottom) *
              0.7,
          child: TransactionList(_transaction, _delete),
        )
      ],
    );
  }

  bool _showChart = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      actions: [
        Container(
          padding: EdgeInsets.only(right: 20),
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
            iconSize: 30,
          ),
        )
      ],
      backgroundColor: Colors.blueGrey,
      title: Text('Money Transaction History!'),
    );
    final body = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape) ..._buildLandscape(mediaQuery, appBar),
            if (!isLandscape) _buildPortrait(mediaQuery, appBar),
          ],
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.grey[400],
      resizeToAvoidBottomPadding: false,
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isLandscape
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
      body: body,
    );
  }
}
