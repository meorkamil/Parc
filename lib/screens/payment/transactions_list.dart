import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/screens/shared/loading.dart';
import 'package:provider/provider.dart';

class TransactionsList extends StatefulWidget {
  @override
  _TransactionsListState createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  getDate(DateTime inputVal) {
    String processedDate;
    processedDate = inputVal.year.toString() +
        '-' +
        inputVal.month.toString() +
        '-' +
        inputVal.day.toString();
    return processedDate;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user.uid);
    return Scaffold(
      appBar: new AppBar(
        title: Center(
          child: Text(
            'Transactions',
            style: TextStyle(
              color: Colors.indigo[900],
              fontFamily: 'Montserrat-Bold',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0.0,
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('transactions')
              .where('uid', isEqualTo: user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Loading();
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildTripCard(context, snapshot.data.documents[index]));
            ;
          }),
    );
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot car) {
    // ProgressDialog dialog = new ProgressDialog(context);
    //dialog.style(message: 'Please wait...');
    return new Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: // Row(children: <Widget>[Text(car['noplate'])]),
              ListTile(
            leading: CircleAvatar(
                radius: 20.0,
                child: Icon(Icons.check, color: Colors.white),
                backgroundColor: Colors.green),
            title: Text(
              car['noplate'],
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            subtitle: Text(
              'Paid at ' + getDate(car['time'].toDate()),
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
