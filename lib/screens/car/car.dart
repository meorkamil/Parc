import 'package:flutter/material.dart';
import 'package:parc_app/models/parc.dart';
import 'package:parc_app/screens/car/car_list.dart';
import 'package:parc_app/screens/car/settings_form.dart';
import 'package:parc_app/screens/home/parc_list.dart';
import 'package:parc_app/services/auth.dart';
import 'package:parc_app/services/database.dart';
import 'package:provider/provider.dart';

//Not Applicable
void main() => runApp(Car());

class Car extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CarWidget());
  }
}

class CarWidget extends StatefulWidget {
  @override
  _CarWidgetState createState() => _CarWidgetState();
}

class _CarWidgetState extends State<CarWidget> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
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

    return StreamProvider<List<Parc>>.value(
      value: DatabaseService().parc,
      child: Scaffold(
          appBar: AppBar(
              title: Text('Parc'),
              backgroundColor: Colors.indigo,
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    label:
                        Text('logout', style: TextStyle(color: Colors.white))),
                FlatButton.icon(
                    onPressed: () => _showSettingsPanel(),
                    icon: Icon(Icons.settings),
                    label: Text('settings'))
              ]),
          body: Center(child: CarList())),
    );
    // return StreamProvider<List<Car>>.value(
    //   value: DatabaseService().car,
    //   child: Scaffold(
    //     appBar: AppBar(
    //         title: Text('Parc'),
    //         backgroundColor: Colors.white,
    //         elevation: 0.0,
    //         actions: <Widget>[
    //           FlatButton.icon(
    //               onPressed: () => _showSettingsPanel(),
    //               icon: Icon(Icons.add),
    //               label: Text('car'))
    //         ]),
    //     body: Center(child: CarList()),
    //   ),
    // );
  }
}
