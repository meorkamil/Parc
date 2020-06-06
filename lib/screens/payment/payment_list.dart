import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parc_app/models/transactions.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/screens/payment/payment_tile.dart';
import 'package:parc_app/services/database.dart';
import 'package:provider/provider.dart';

//Not Applicable
class PaymentList extends StatefulWidget {
  @override
  _PaymentListState createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final transactions = Provider.of<List<Transactions>>(context) ?? [];
    return StreamBuilder<List<Transactions>>(
        stream: DatabaseService(uid: user.uid).transactions,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return PaymentTile(transaction: transactions[index]);
            },
          );
        });
  }
}
