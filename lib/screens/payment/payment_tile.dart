import 'package:flutter/material.dart';
import 'package:parc_app/models/transactions.dart';
import 'package:parc_app/services/database.dart';

//Not Applicable
class PaymentTile extends StatelessWidget {
  final Transactions transaction;
  PaymentTile({this.transaction});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
              radius: 25.0,
              child: Icon(Icons.check, color: Colors.white),
              backgroundColor: Colors.green),
          title: Text(transaction.carID),
          subtitle: Text(
            'Paid',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
