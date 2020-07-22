import "package:flutter/foundation.dart";

class Transaction {
  @required
  final String id;
  @required
  final String expenseName;
  @required
  final num expenseAmount;
  @required
  final DateTime timestamp;

  Transaction({this.id, this.expenseName, this.expenseAmount, this.timestamp});
}
