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
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 24, 24, 1),
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
        builder: (context) => FloatingActionButton(
          onPressed: () => _showTransactionInputBox(context),
          child: Icon(Icons.add),
          backgroundColor: Colors.orange[400],
          foregroundColor: Colors.black,
          splashColor: Colors.orange[900],
        ),
      ),
      backgroundColor: Color.fromRGBO(15, 15, 15, 1),
    ));
  }
}
