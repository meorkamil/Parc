import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parc_app/models/car.dart';
import 'package:parc_app/models/user.dart';
import 'dart:convert';
import 'package:parc_app/services/database.dart';
import 'package:provider/provider.dart';

class CarTile extends StatelessWidget {
  final Car car;
  CarTile({this.car});
  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentNoplate;
  // Blob tBlob = "UGFpZA==";
  // String result = base64Decode(tBlob);
  Base64Codec base64 = const Base64Codec();
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    String credentials = "Upaid";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded =
        stringToBase64.encode(credentials); // dXNlcm5hbWU6cGFzc3dvcmQ=

    @override

    // void _showUpdateForm() {
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (context) {
    //         return Container(
    //           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
    //           child: UpdateCar(),
    //         );
    //       });
    // }

    Future<bool> updateDialog(BuildContext context, selectedDoc) async {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Form(
              key: _formKey,
              child: AlertDialog(
                title: Text('Update Car', style: TextStyle(fontSize: 15.0)),
                content: Container(
                  height: 125.0,
                  width: 150.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                          // decoration: InputDecoration(hintText: car.noplate),
                          initialValue: car.noplate,
                          validator: (val) =>
                              val.isEmpty ? 'Please enter No Plate' : null,
                          onChanged: (value) {
                            this._currentName = value;
                          }

                          //initialValue: car.noplate,
                          ),
                      SizedBox(height: 5.0),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Update'),
                    textColor: Colors.blue,
                    onPressed: () async {
                      var trimNo = _currentName
                          .replaceAll(new RegExp(r"\s+\b|\b\s"), "")
                          .toUpperCase();
                      print(trimNo);
                      Navigator.of(context).pop();
                      await DatabaseService(uid: user.uid)
                          .updateCarsDataDoc(trimNo ?? car.noplate, car.docID);
                    },
                  )
                ],
              ),
            );
          });
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
              radius: 20.0,
              child: Icon(Icons.directions_car, color: Colors.white),
              backgroundColor: Colors.indigo),
          // leading: Icon(Icons
          //     .directions_car,
          //     color: Colors.indigo[900],),
          title: Text(
            car.noplate,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          subtitle: Text(car.status),
          trailing: Wrap(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.yellow[800],
                  ),
                  onPressed: () => updateDialog(context, car.docID)),
              IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                onPressed: () async {
                  await DatabaseService(uid: user.uid)
                      .deleteCarsData(car.docID);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
