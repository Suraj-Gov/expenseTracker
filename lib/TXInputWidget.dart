/// This is the widget that builds the input for transactions.
import "package:flutter/material.dart";

class TXInputWidget extends StatefulWidget {
  final Function submitFunction;

  TXInputWidget(this.submitFunction);

  @override
  _TXInputWidgetState createState() => _TXInputWidgetState();
}

class _TXInputWidgetState extends State<TXInputWidget> {
  final txNameInput = TextEditingController();

  final txAmountInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 30),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.23,
          decoration: BoxDecoration(
              color: Color.fromRGBO(30, 30, 30, 1),
              borderRadius: BorderRadius.all(Radius.circular(20))),
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
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromRGBO(18, 18, 18, 1),
                      ),
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: TextField(
                        maxLength: 50,
                        onSubmitted: (_) => (txNameInput.text != "")
                            ? widget.submitFunction(
                                context, txNameInput.text, txAmountInput.text)
                            : null,
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
                          hintText: "Expense Name",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[700],
                            fontSize: 17,
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
                        maxLength: 50,
                        onSubmitted: (_) => (txAmountInput.text != "" ||
                                num.parse(txAmountInput.text) <= 0)
                            ? widget.submitFunction(
                                context, txNameInput.text, txAmountInput.text)
                            : null,
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
                          hintText: "Amount",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[700],
                            fontSize: 17,
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: FlatButton(
                    textTheme: ButtonTextTheme.accent,
                    disabledTextColor: Colors.grey[700],
                    onPressed: (txNameInput.text != "" &&
                            txAmountInput.text != "" &&
                            num.parse(txAmountInput.text) > 0)
                        ? () => widget.submitFunction(
                            context, txNameInput.text, txAmountInput.text)
                        : null,
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
