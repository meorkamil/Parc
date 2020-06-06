import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parc_app/screens/shared/utility.dart';

//Not Applicable
class StatusQuery extends StatefulWidget {
  @override
  _StatusQueryState createState() => _StatusQueryState();
}

class _StatusQueryState extends State<StatusQuery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('testing')),
      body: StreamBuilder(
        stream: Firestore.instance.collection('cars').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('loading');
          return Column(children: <Widget>[
            Text(
              snapshot.data.documents[2]['noplate'].toString(),
              style: TextStyle(fontSize: 45.0),
            ),
            Text(
              snapshot.data.documents[2]['status'].toString(),
              style: TextStyle(fontSize: 45.0),
            )
          ]);
        },
      ),
    );
  }
}
