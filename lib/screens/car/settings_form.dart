import 'package:flutter/material.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/screens/shared/constants.dart';
import 'package:parc_app/services/database.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  String noPlate;
  String _currentNoplate;

  successCar() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Your car registered in Parc !'),
    ));
  }

  errorCar() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Car already exist !'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
    final user = Provider.of<User>(context);
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        Text(
          'Add Car',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
          decoration: textInputDecoration,
          validator: (val) => val.isEmpty ? 'Please enter a name' : null,
          onChanged: (val) => setState(() => noPlate = val),
        ),
        SizedBox(height: 20.0),
        // TextFormField(
        //   decoration: textInputDecoration,
        //   validator: (val) =>
        //       val.isEmpty ? 'Please enter vehicle no plate' : null,
        //   onChanged: (val) => setState(() => _currentNoplate = val),
        // ),
        RaisedButton(
            color: Colors.pinkAccent,
            child: Text('Add', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                var trimNo = noPlate
                    .replaceAll(new RegExp(r"\s+\b|\b\s"), "")
                    .toUpperCase();
                // print(trimNo);
                dynamic result =
                    await DatabaseService(uid: user.uid).updateCarsData(trimNo);
                if (result == null) return errorCar();
                Navigator.pop(context);
                successCar();
              }
              //print(_currentName);
              //print(_currentNoplate);
            })
      ]),
    );
  }
}
