import "package:flutter/material.dart";
import "./TXListWidget.dart";
import "./TXInputWidget.dart";
import "./Transaction.dart";
import './Chart.dart';
import "dart:ui";

class MainWidgets extends StatefulWidget {
  @override
  _MainWidgetsState createState() => _MainWidgetsState();
}

class _MainWidgetsState extends State<MainWidgets> {
  final _transactionList = List<Transaction>();

  List<Transaction> get _recentTransactions {
    return _transactionList
        .where((i) =>
            i.timestamp.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _showTransactionInputBox(BuildContext ctx) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isDismissible: true,
        isScrollControlled: true,
        barrierColor: Colors.black38,
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            child: TXInputWidget((context, name, amt, date) =>
                _addTransaction(context, name, amt, date)),
            onTap: () {
              // to exit from keyboard, tap anywhere on the input widget
              // this will unfocus the keyboard :)
              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
            },
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _showChartWidget(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        backgroundColor: Color.fromRGBO(18, 18, 18, 0.98),
        isDismissible: true,
        isScrollControlled: true,
        barrierColor: Colors.black38,
        builder: (bCtx) {
          return Container(
            child: Chart(this._recentTransactions),
          );
        });
  }

  void _addTransaction(
      BuildContext context, String name, String amt, DateTime date) {
    setState(() {
      _transactionList.insert(
          0,
          Transaction(
              expenseAmount: num.parse(num.parse(amt).toString()),
              expenseName: name.toString(),
              id: DateTime.now().toString(),
              timestamp: date));
    });

    Navigator.of(context).pop();
    // this just pops the upper most block of widget
    // i.e the modal input box when user submits input
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final mainWidgetsAppBar = AppBar(
      elevation: Theme.of(context).appBarTheme.elevation,
      backgroundColor: Theme.of(context).appBarTheme.color,
      title: Text(
        "Expense Tracker",
      ),
      actions: <Widget>[
        if (mediaQuery.orientation == Orientation.landscape)
          IconButton(
            padding: EdgeInsets.only(right: 20),
            icon: Icon(Icons.show_chart),
            onPressed: () => _showChartWidget(context),
            alignment: Alignment.centerRight,
            color: Theme.of(context).accentColor,
          )
      ],
    );

    final _isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      appBar: mainWidgetsAppBar,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return _transactionList.isEmpty
              ? Container(
                  padding: EdgeInsets.only(top: 30),
                  width: double.infinity,
                  child: Text(
                    "No transactions added.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],
                    ),
                  ),
                )
              : Column(
                  children: <Widget>[
                    if (!_isLandscape)
                      Expanded(
                        child: Chart(this._recentTransactions),
                      ),
                    SingleChildScrollView(
                        child: Container(
                      height: (!_isLandscape)
                          ? constraints.maxHeight * 0.65
                          : constraints.maxHeight * 1,
                      child: TXListWidget(
                        transactionList: _transactionList,
                      ),
                    )),
                  ],
                );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton.extended(
          onPressed: () => _showTransactionInputBox(context),
          label: Text(
            "Add transaction".toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          icon: Icon(Icons.account_balance_wallet),
          backgroundColor: Theme.of(context).accentColor,
          foregroundColor: Colors.black,
          splashColor: Colors.orange[900],
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
