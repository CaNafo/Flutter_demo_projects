import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/tansaction_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: "t1", title: "New Shoes", amount: 99.75, date: DateTime.now()),
    Transaction(
        id: "t2",
        title: "Weekly groceries",
        amount: 15.41,
        date: DateTime.now()),
    Transaction(
        id: "t3",
        title: "Socks",
        amount: 1.41,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: "t4",
        title: "Fuel",
        amount: 20,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: "t5",
        title: "Bread",
        amount: 3.70,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        id: "t6",
        title: "Haircut",
        amount: 17.50,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        id: "t7",
        title: "Coffe",
        amount: 5,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        id: "t8",
        title: "Jeans",
        amount: 50.66,
        date: DateTime.now().subtract(Duration(days: 2)))
  ];

  bool showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime dateTime) {
    final newTX = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: dateTime);

    setState(() {
      _userTransactions.add(newTX);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String transactionID) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == transactionID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () {
                    _startAddNewTransaction(context);
                  },
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    _startAddNewTransaction(context);
                  },
                  icon: Icon(Icons.add))
            ],
          );
    final txListWidged = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.70,
        child: TransactionList(_userTransactions, _deleteTransaction));

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart"),
                  Switch.adaptive(
                      value: showChart,
                      onChanged: (value) {
                        setState(() {
                          showChart = value;
                        });
                      }),
                ],
              ),
            if (!isLandscape)
              Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentTransactions)),
            if (!isLandscape) txListWidged,
            if (isLandscape)
              showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions))
                  : txListWidged
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      _startAddNewTransaction(context);
                    },
                  ),
          );
  }
}
