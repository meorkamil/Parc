import 'package:flutter/material.dart';
import 'package:parc_app/models/transactions.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/screens/payment/payment_list.dart';
import 'package:parc_app/services/database.dart';
import 'package:provider/provider.dart';

//Not Applicable
class HomePayment extends StatefulWidget {
  @override
  _HomePaymentState createState() => _HomePaymentState();
}

class _HomePaymentState extends State<HomePayment> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<List<Transactions>>.value(
      value: DatabaseService(uid: user.uid).transactions,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Transactions',
              style: TextStyle(
                color: Colors.indigo[900],
                fontFamily: 'Montserrat-Bold',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: Colors.grey[50],
          elevation: 0.0,
          // actions: <Widget>[
          //   FlatButton.icon(
          //       onPressed: () => _showSettingsPanel(),
          //       icon: Icon(Icons.add),
          //       label: Text('Car'))
          // ]
        ),
        body: Center(child: PaymentList()),
      ),
    );
  }
}
