import 'package:flutter/material.dart';
import 'package:parc_app/models/car.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/screens/car/settings_form.dart';
import 'package:parc_app/services/auth.dart';
import 'package:parc_app/services/database.dart';
import 'package:provider/provider.dart';

import 'car_list.dart';

void main() => runApp(HomeCar());

class HomeCar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeCarWidget(),
    );
  }
}

class HomeCarWidget extends StatefulWidget {
  @override
  _HomeCarWidget createState() => _HomeCarWidget();
}

class _HomeCarWidget extends State<HomeCarWidget> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Car>>.value(
      value: DatabaseService(uid: user.uid).car,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Cars',
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
        body: Center(child: CarList()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showSettingsPanel(),
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
