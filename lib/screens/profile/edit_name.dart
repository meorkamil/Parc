import 'package:flutter/material.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/screens/shared/constants.dart';
import 'package:parc_app/services/database.dart';
import 'package:provider/provider.dart';

class EditName extends StatefulWidget {
  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  final _formKey = GlobalKey<FormState>();
  String name;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        SizedBox(height: 20.0),
        Text(
          'Edit Name',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
          decoration: textInputDecoration.copyWith(hintText: 'Name'),
          validator: (val) => val.isEmpty ? 'New Name' : null,
          onChanged: (val) => setState(() => name = val),
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
            child: Text('Update', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                // print(trimNo);
                await DatabaseService(uid: user.uid).updateUserName(name);
                Navigator.pop(context);
                // successCar();
              }
              //print(_currentName);
              //print(_currentNoplate);
            })
      ]),
    );
  }
}
