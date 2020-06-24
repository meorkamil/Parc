import 'package:flutter/material.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/screens/shared/constants.dart';
import 'package:parc_app/services/auth.dart';
import 'package:parc_app/services/database.dart';
import 'package:provider/provider.dart';

class ChangeContact extends StatefulWidget {
  @override
  _ChangeContactState createState() => _ChangeContactState();
}

class _ChangeContactState extends State<ChangeContact> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String contactNo;
  String error = "";

  successChange() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Your contact no has changed !'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        SizedBox(height: 20.0),

        Text(
          'Change Contact No',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
          decoration: textInputDecoration.copyWith(hintText: 'Contact No'),
          validator: (val) => val.isEmpty ? 'Contact No is required' : null,
          onChanged: (val) => setState(() => contactNo = val),
        ),
        SizedBox(height: 20.0),
        Text(
          error,
          style: TextStyle(
            color: Colors.red[200],
          ),
        ),
        // TextFormField(
        //   decoration: textInputDecoration,
        //   validator: (val) =>
        //       val.isEmpty ? 'Please enter vehicle no plate' : null,
        //   onChanged: (val) => setState(() => _currentNoplate = val),
        // ),
        RaisedButton(
            color: Colors.pinkAccent,
            child: Text('Submit', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                // print(trimNo);
                await DatabaseService(uid: user.uid).updateContactNo(contactNo);
                Navigator.pop(context);
                // await _auth.updatePassword(password);
                // Navigator.pop(context);
                // successChange();

                // successCar();
              }
              //print(_currentName);
              //print(_currentNoplate);
            })
      ]),
    );
  }
}
