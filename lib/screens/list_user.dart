import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/services/auth.dart';
import 'package:provider/provider.dart';

class ListUser extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
            stream: getUsersTripsStreamSnapshots(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('loding');
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildTripCard(context, snapshot.data.documents[index]));
            }));
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    final user = Provider.of<User>(context);
    yield* Firestore.instance
        .collection('users')
        .document(user.uid)
        .collection('cars')
        .snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot car) {
    return new Container(
        child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: <Widget>[Text(car['noplate'])]),
      ),
    ));
  }
}
