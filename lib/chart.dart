import 'package:expenseTracker/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "./Transaction.dart";

class Chart extends StatelessWidget {
  final List<Transaction> transactionList;

  Chart(this.transactionList);

  List<Map<String, Object>> get summary {
    return List.generate(7, (index) {
      num totalAmount = 0;
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );

      transactionList.forEach((i) {
        if (i.timestamp.day == weekday.day &&
            i.timestamp.month == weekday.month &&
            i.timestamp.year == weekday.year) {
          totalAmount += i.expenseAmount;
        }
      });

      return {
        "day": DateFormat.E().format(weekday),
        "amount": totalAmount,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(summary);
    return Container();
  }
}
