import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:parc_app/screens/car/car.dart';
import 'package:parc_app/screens/car/status_query.dart';
import 'package:parc_app/screens/home/home.dart';
import 'package:parc_app/screens/car/home_car.dart';
import 'package:parc_app/screens/home/pay_car.dart';
import 'package:parc_app/screens/payment/home_payment.dart';
import 'package:parc_app/screens/payment/payment.dart';
import 'package:parc_app/screens/payment/transactions_list.dart';
import 'package:parc_app/screens/profile/profile.dart';

void main() => runApp(MaterialApp(
      home: Menu(),
    ));

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final _pageOption = [
    PayCar(),
    HomeCar(),
    TransactionsList(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.directions_car, size: 30, color: Colors.white),
          Icon(Icons.payment, size: 30, color: Colors.white),
          Icon(Icons.perm_identity, size: 30, color: Colors.white),
        ],
        color: Colors.indigo[900],
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 170),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: _pageOption[_page],
    );
  }
}
