import 'package:flutter/material.dart';
import 'package:parc_app/models/car.dart';
import 'package:parc_app/models/parc.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/screens/home/settings_form.dart';
import 'package:parc_app/screens/home/unpaid_list.dart';
import 'package:parc_app/services/auth.dart';
import 'package:parc_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:parc_app/screens/home/parc_list.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeWidget());
  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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
      value: DatabaseService(uid: user.uid).unpaidCar,
      child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                'Parc',
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
            //       onPressed: () async {
            //         await _auth.signOut();
            //       },
            //       icon: Icon(
            //         Icons.cancel,
            //         color: Colors.white,
            //       ),
            //       label:
            //           Text('logout', style: TextStyle(color: Colors.white))),
            //   FlatButton.icon(
            //       onPressed: () => _showSettingsPanel(),
            //       icon: Icon(Icons.settings),
            //       label: Text('settings'))
            // ]
          ),
          body: Center(child: UnpaidList())),
    );
  }
}
