/// This is the widget that builds the input for transactions.
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class TXInputWidget extends StatefulWidget {
  final Function submitFunction;

  TXInputWidget(this.submitFunction);

  @override
  _TXInputWidgetState createState() => _TXInputWidgetState();
}

class _TXInputWidgetState extends State<TXInputWidget> {
  final txNameInput = TextEditingController();
  DateTime dateSelected;
  final txAmountInput = TextEditingController();

  bool inputValidation() {
    // (txNameInput.text != "" &&
    //     txAmountInput.text != "" &&
    //     num.parse(txAmountInput.text) > 0)
    //                       ? widget.submitFunction(
    //                           context, txNameInput.text, txAmountInput.text);
    if (txNameInput.text.isNotEmpty &&
        txAmountInput.text.isNotEmpty &&
        num.parse(txAmountInput.text) > 0 &&
        dateSelected != null) {
      widget.submitFunction(
          context, txNameInput.text, txAmountInput.text, dateSelected);
      return true;
    } else
      return null;
  }

  void showDateInput(BuildContext ctx) {
    showDatePicker(
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null)
        return;
      else
        setState(() {
          dateSelected = date;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 30),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Color.fromRGBO(30, 30, 30, 1),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 5),
                blurRadius: 15,
                spreadRadius: 6,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(18, 18, 18, 1),
                      ),
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: TextField(
                        maxLength: 50,
                        onSubmitted: (_) => inputValidation,
                        controller: txNameInput,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).accentColor,
                        decoration: InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                          hintText: "Expense Name".toUpperCase(),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(18, 18, 18, 1),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: TextField(
                        maxLength: 8,
                        onSubmitted: (_) => inputValidation,
                        controller: txAmountInput,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        cursorColor: Theme.of(context).accentColor,
                        decoration: InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                          hintText: "Amount".toUpperCase(),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[700],
                            fontSize: 14,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(20, 20, 20, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    dateSelected != null
                                        ? DateFormat.yMMMMd("en_US")
                                            .format(dateSelected)
                                        : "No Date Chosen",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Set Date".toUpperCase(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            color: Color.fromRGBO(26, 26, 26, 1),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            textColor: Colors.orange,
                            onPressed: () => showDateInput(context),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  textTheme: ButtonTextTheme.accent,
                  disabledTextColor: Colors.grey[800],
                  onPressed: (txNameInput.text.isNotEmpty &&
                          txAmountInput.text.isNotEmpty &&
                          num.parse(txAmountInput.text) > 0 &&
                          dateSelected != null)
                      ? inputValidation
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Add Expense".toUpperCase(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
