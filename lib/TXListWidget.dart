/// This is the widget that builds the List of TXWidgets.
import 'package:expenseTracker/Transaction.dart';
import "package:flutter/material.dart";
import './TXWidget.dart';

class TXListWidget extends StatelessWidget {
  final List<Transaction> transactionList;

  TXListWidget({@required this.transactionList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return TXWidget(
              amount: transactionList[index].expenseAmount,
              date: transactionList[index].timestamp,
              id: transactionList[index].id,
              name: transactionList[index].expenseName,
            );
          },
          itemCount: transactionList.length,
          padding: EdgeInsets.all(6),
        ),
      ),
    );
  }
}
