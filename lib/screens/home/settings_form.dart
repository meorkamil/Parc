import 'package:flutter/material.dart';
import 'package:parc_app/screens/shared/constants.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/screens/shared/loading.dart';
import 'package:parc_app/services/database.dart';
import 'package:provider/provider.dart';

//Not applicable
class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentNoplate;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Text(
                  'Update personal',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) =>
                      val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
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
                    child:
                        Text('Update', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name,
                            _currentNoplate ?? userData.email);
                        Navigator.pop(context);
                      }
                      //print(_currentNoplate);
                    })
              ]),
            );
          } else {
            return Loading();
          }
        });
  }
}
