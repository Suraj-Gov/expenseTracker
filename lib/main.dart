/// This is the main file that gets executed first.
import "package:flutter/material.dart";
import "./TXMash.dart";

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
      body: SingleChildScrollView(child: TXMash()),
      backgroundColor: Color.fromRGBO(15, 15, 15, 1),
    ));
  }
}
