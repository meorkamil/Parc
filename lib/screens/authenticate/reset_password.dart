import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parc_app/screens/authenticate/sign_in.dart';
import 'package:parc_app/screens/shared/constants.dart';
import 'package:parc_app/services/auth.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email;
  successCar() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Link has been sent"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        Text(
          'Enter Email',
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
          onChanged: (val) => setState(() => email = val),
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
            child: Text('Reset', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                // print(trimNo);
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: email);
                Navigator.pop(context);
                SignIn();
                // successCar();
              }
              //print(_currentName);
              //print(_currentNoplate);
            })
      ]),
    );
  }
}
