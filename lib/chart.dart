import 'package:expenseTracker/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Transaction.dart';

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

  num get totalSpending {
    return summary.fold(0.0, (total, i) => total + i["amount"]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ...summary.reversed.map((i) => Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.11,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                          child: Text(
                            '\$${i["amount"]}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.04,
                          height: MediaQuery.of(context).size.height * 0.12,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromRGBO(25, 25, 25, 1),
                              border: Border.all(
                                color: Color.fromARGB(85, 85, 85, 1),
                                width: 2,
                              )),
                          child: FractionallySizedBox(
                            alignment: Alignment.bottomCenter,
                            heightFactor: totalSpending > 0
                                ? (i["amount"] as num) / totalSpending
                                : 0.0,
                            widthFactor: 0.8,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        i["day"],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
