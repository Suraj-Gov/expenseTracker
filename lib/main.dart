import "package:flutter/material.dart";
import "./TXListWidget.dart";
import "./TXInputWidget.dart";

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 24, 24, 1),
        title: Text(
          "Expense Tracker",
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(15, 15, 15, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TXInputWidget((val) => print(val)),
            TXListWidget()
          ],
        ),
      ),
    ));
  }
}
