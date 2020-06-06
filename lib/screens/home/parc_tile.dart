import 'package:flutter/material.dart';
import 'package:parc_app/models/parc.dart';
import 'package:parc_app/models/user.dart';

class ParcTile extends StatelessWidget {
  final Parc parc;
  ParcTile({this.parc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(radius: 25.0, backgroundColor: Colors.indigo),
          title: Text(parc.name),
          subtitle: Text(parc.noplate),
        ),
      ),
    );
  }
}
