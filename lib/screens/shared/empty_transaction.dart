import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EmptyTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Text('No Transactions',
                style: TextStyle(
                  fontFamily: 'Montserrat-bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ))));
  }
}
