import "package:flutter/material.dart";
import "./Transaction.dart";
import './TXWidget.dart';

class TXListWidget extends StatefulWidget {
  @override
  _TXListWidgetState createState() => _TXListWidgetState();
}

class _TXListWidgetState extends State<TXListWidget> {
  List<Transaction> txList = [
    Transaction(
      expenseAmount: 12,
      expenseName: "Milk",
      id: "001",
      timestamp: DateTime.now(),
    ),
    Transaction(
      expenseAmount: 14,
      expenseName: "Turd",
      id: "002",
      timestamp: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: txList
          .map((i) => TXWidget(
                amount: i.expenseAmount,
                date: i.timestamp,
                id: i.id,
                name: i.expenseName,
              ))
          .toList(),
    );
  }
}
