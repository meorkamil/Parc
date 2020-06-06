import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NoUnpaid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Text('Start Parking Now',
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'Montserrat-bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ))));
  }
}
