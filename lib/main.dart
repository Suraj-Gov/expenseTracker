/// This is the main file that gets executed first.
import "package:flutter/material.dart";
import "./TXListWidget.dart";
import "./TXInputWidget.dart";
import "./Transaction.dart";
import "./chart.dart";

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _transactionList = List<Transaction>();

  List<Transaction> get _recentTransactions {
    return _transactionList
        .where((i) =>
            i.timestamp.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _showTransactionInputBox(BuildContext ctx) {
    showModalBottomSheet(
        backgroundColor: Color.fromRGBO(15, 15, 15, 1),
        isDismissible: true,
        isScrollControlled: true,
        barrierColor: Colors.black38,
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            child: TXInputWidget((context, name, amt, date) =>
                _addTransaction(context, name, amt, date)),
            onTap: () => print("tapped on the input widget space"),
            behavior: HitTestBehavior.opaque,
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
    return MaterialApp(
        theme: ThemeData(
            accentColor: Colors.orange,
            backgroundColor: Color.fromRGBO(15, 15, 15, 1),
            fontFamily: 'Poppins',
            appBarTheme: AppBarTheme(
              color: Color.fromRGBO(35, 35, 35, 1),
              elevation: 10,
            )),
        home: Scaffold(
          appBar: AppBar(
            elevation: Theme.of(context).appBarTheme.elevation,
            backgroundColor: Theme.of(context).appBarTheme.color,
            title: Text(
              "Expense Tracker",
            ),
          ),
          body: Column(
            children: <Widget>[
              Chart(this._recentTransactions),
              SingleChildScrollView(
                  child: Container(
                height: 410,
                child: TXListWidget(
                  transactionList: _transactionList,
                ),
              )),
            ],
          ),
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton.extended(
              onPressed: () => _showTransactionInputBox(context),
              label: Text(
                "Add transaction".toUpperCase(),
                strutStyle: StrutStyle(
                  height: 0,
                ),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              icon: Icon(Icons.add_circle),
              backgroundColor: Theme.of(context).accentColor,
              foregroundColor: Colors.black,
              splashColor: Colors.orange[900],
            ),
          ),
          backgroundColor: Color.fromRGBO(15, 15, 15, 1),
        ));
  }
}
