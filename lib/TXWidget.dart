/// This the widget that builds the transaction data.
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

    var wholeAmount = Text(
      '\$${getWholeAmount()}',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          // card and the date thing below
          children: <Widget>[
            Container(
              //
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(3),
                ),
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
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Text(
                          this.widget.name,
                          style: TextStyle(
                            fontSize: this.widget.name.length < 18 ? 20 : 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: wholeAmount,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(2, 0, 0, 4.5),
                                child: Text(
                                  getPennies(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 7, 5),
                  child: Text(
                    DateFormat.yMMMMd("en_US").format(this.widget.date),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15,
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
