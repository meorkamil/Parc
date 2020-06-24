import 'package:flutter/material.dart';
import 'package:parc_app/screens/shared/constants.dart';
import 'package:parc_app/services/auth.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String password;
  String confirmpassword;
  String error = "";

  successChange() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Your Password has changed'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        SizedBox(height: 20.0),

        Text(
          'Change Password',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
          decoration: textInputDecoration.copyWith(hintText: 'Password'),
          validator: (val) => val.isEmpty ? 'New Password is required' : null,
          onChanged: (val) => setState(() => password = val),
          obscureText: true,
        ),

        TextFormField(
          decoration:
              textInputDecoration.copyWith(hintText: 'Confitm Password'),
          validator: (val) =>
              val.isEmpty ? 'Confirm Passowrd is required' : null,
          onChanged: (val) => setState(() => confirmpassword = val),
          obscureText: true,
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
                if (password == confirmpassword) {
                  await _auth.updatePassword(password);
                  Navigator.pop(context);
                  successChange();
                }
                if (password != confirmpassword) {
                  setState(() {
                    error = "Password not match";
                  });
                }

                // successCar();
              }
              //print(_currentName);
              //print(_currentNoplate);
            })
      ]),
    );
    ;
  }
}
