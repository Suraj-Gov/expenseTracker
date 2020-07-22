import "package:flutter/material.dart";

class TXInputWidget extends StatelessWidget {
  final txNameInput = TextEditingController();
  final txAmountInput = TextEditingController();
  final Function submitFunction;

  TXInputWidget(this.submitFunction);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
            color: Color.fromRGBO(30, 30, 30, 1),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(18, 18, 18, 0.4),
                blurRadius: 10,
                spreadRadius: 4,
                offset: Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color.fromRGBO(18, 18, 18, 1),
              ),
              width: MediaQuery.of(context).size.width * 0.55,
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                keyboardType: TextInputType.text,
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  hintText: "Expense Name",
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                keyboardType: TextInputType.text,
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  hintText: "Amount",
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
