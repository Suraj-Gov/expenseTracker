/// This the main collective widget that houses the
/// TXWidgets in a TXListWidget along with the TXInputWidget.
///
/// The TX state is stored here.
import './Transaction.dart';
import "package:flutter/material.dart";
import "./TXListWidget.dart";
import "./TXInputWidget.dart";

class TXMash extends StatefulWidget {
  @override
  _TXMashState createState() => _TXMashState();
}

class _TXMashState extends State<TXMash> {
  final transactionList = List<Transaction>();

  void _addTransaction(String name, num amt) {
    if (name.length == 0 || amt <= 0) return;

    setState(() {
      transactionList.insert(
          0,
          Transaction(
              expenseAmount: amt,
              expenseName: name.toString(),
              id: DateTime.now().toString(),
              timestamp: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TXInputWidget((name, amt) => _addTransaction(name, num.parse(amt))),
        TXListWidget(
          transactionList: transactionList,
        )
      ],
    );
  }
}
