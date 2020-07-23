/// This is the main file that gets executed first.
import "package:flutter/material.dart";
import "./TXListWidget.dart";
import "./TXInputWidget.dart";
import "./Transaction.dart";

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final transactionList = List<Transaction>();

  void _showTransactionInputBox(BuildContext ctx) {
    showModalBottomSheet(
        backgroundColor: Color.fromRGBO(15, 15, 15, 1),
        isDismissible: true,
        barrierColor: Colors.black38,
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            child: TXInputWidget(
                (context, name, amt) => _addTransaction(context, name, amt)),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _addTransaction(BuildContext context, String name, String amt) {
    if (name == "" && amt == "") {
      print("both values are null");
      return;
    } else if (name == "") {
      print("name is null");
      return;
    } else if (amt == "") {
      print("amt is null");
      return;
    } else if (num.parse(amt) <= 0) {
      print("amt is less than or equal to 0");
      return;
    }

    setState(() {
      transactionList.insert(
          0,
          Transaction(
              expenseAmount: num.parse(num.parse(amt).toString()),
              expenseName: name.toString(),
              id: DateTime.now().toString(),
              timestamp: DateTime.now()));
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
            backgroundColor: Colors.red,
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
          body: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TXListWidget(
                transactionList: transactionList,
              )
            ],
          )),
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
