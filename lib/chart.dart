import './Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    final mediaQuery = MediaQuery.of(context);

    final _isLandscape = mediaQuery.orientation == Orientation.landscape;

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          width: mediaQuery.size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ...summary.reversed.map((i) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 9.0),
                        child: SizedBox(
                          width: constraints.maxWidth * 0.11,
                          height: constraints.maxHeight * 0.11,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: Text(
                              '\$${i["amount"]}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: _isLandscape ? 25 : 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            width: constraints.maxWidth * 0.06,
                            height: constraints.maxHeight * 0.5,
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
                        child: SizedBox(
                          height: constraints.maxHeight * 0.1,
                          width: constraints.maxWidth * 0.1,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              i["day"],
                              style: TextStyle(
                                fontSize: _isLandscape ? 21 : 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ));
    });
  }
}
