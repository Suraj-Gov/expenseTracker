import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TXWidget extends StatefulWidget {
  final String id;
  final String name;
  final num amount;
  final DateTime date;

  TXWidget(
      {@required this.id,
      @required this.name,
      @required this.amount,
      @required this.date});

  @override
  _TXWidgetState createState() => _TXWidgetState();
}

class _TXWidgetState extends State<TXWidget> {
  List<String> _splitAmounts;

  @override
  Widget build(BuildContext context) {
    String getWholeAmount() {
      _splitAmounts = this.widget.amount.toString().split(".");
      return _splitAmounts.first;
    }

    String getPennies() => _splitAmounts.length > 1 ? _splitAmounts[1] : "00";

    var text = Text(
      '\$${getWholeAmount()}',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          // card and the date thing below
          children: <Widget>[
            Container(
              //
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color.fromRGBO(23, 23, 23, 1),
                border: Border.all(
                  color: Color.fromRGBO(20, 20, 20, 1),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Text(
                        this.widget.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: text,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              getPennies(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
            ),
            // Positioned(
            //   right: 0,
            //   child: Text(
            //     this.date.toString(),
            //     textAlign: TextAlign.right,
            //     style: TextStyle(
            //       fontSize: 10,
            //       fontWeight: FontWeight.w300,
            //       color: Colors.grey,
            //     ),
            //   ),
            // )
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                  child: Text(
                    DateFormat.yMMMMd("en_US").format(this.widget.date),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
