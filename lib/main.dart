/// This is the main file that gets executed first.
import "package:flutter/material.dart";
import "./MainWidgets.dart";

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          accentColor: Colors.orange,
          backgroundColor: Color.fromRGBO(15, 15, 15, 1),
          fontFamily: 'Poppins',
          appBarTheme: AppBarTheme(
            color: Color.fromRGBO(35, 35, 35, 1),
            elevation: 10,
          )),
      home: SafeArea(child: MainWidgets()),
    );
  }
}
