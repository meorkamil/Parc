import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parc_app/models/parc.dart';
import 'package:parc_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:parc_app/screens/home/parc_tile.dart';
import 'package:parc_app/models/user.dart';

class ParcList extends StatefulWidget {
  @override
  _ParcListState createState() => _ParcListState();
}

class _ParcListState extends State<ParcList> {
  @override
  Widget build(BuildContext context) {
    final parcs = Provider.of<List<Parc>>(context) ?? [];
    final user = Provider.of<User>(context);
    //final userData = Provider.of<UserData>(context);

    //print(userData.email);
    return StreamBuilder<List<Parc>>(
        stream: DatabaseService(uid: user.uid).parc,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: parcs.length,
            itemBuilder: (context, index) {
              return ParcTile(parc: parcs[index]);
            },
          );
        });
  }
}
