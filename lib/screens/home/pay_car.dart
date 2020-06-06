import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parc_app/models/car.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/screens/shared/loading.dart';
import 'package:parc_app/screens/shared/no_unpaid.dart';
import 'package:parc_app/services/payment_services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:parc_app/services/database.dart';

class PayCar extends StatefulWidget {
  @override
  _PayCarState createState() => _PayCarState();
}

class _PayCarState extends State<PayCar> {
  payViaNewCard(
      BuildContext context, String docID, String uid, String noplate) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response = await StripeService.payWithNewCard(
        amount: '1000', currency: 'MYR', documentID: docID);
    await dialog.hide();
    //response.success;
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration:
          new Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));

    if (response.success == true) {
      await DatabaseService().updateCarPayment(docID);
      await DatabaseService().addTransaction(docID, uid, noplate);
    }
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: new AppBar(
        title: Center(
          child: Text(
            'Parc',
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
              .collection('cars')
              .where('uid', isEqualTo: user.uid) //user.uid)
              .where('status', isEqualTo: 'Unpaid')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data.documents.isEmpty) {
              return NoUnpaid();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildTripCard(context, snapshot.data.documents[index]));
            }
          }),
    );
    // return Padding(
    //   padding: EdgeInsets.only(top: 8.0),
    //   child: Card(
    //     margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
    //     child: ListTile(
    //       leading: CircleAvatar(radius: 25.0, backgroundColor: Colors.indigo),
    //       // title: Text(car.status),
    //       // subtitle: Text(car.noplate),
    //       trailing: Wrap(children: <Widget>[
    //         IconButton(
    //             icon: Icon(
    //               Icons.payment,
    //               color: Colors.yellow[800],
    //             ),
    //             onPressed: () => payViaNewCard(context))
    //       ]),
    //     ),
    //   ),
    // );
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot car) {
    ProgressDialog dialog = new ProgressDialog(context);

    if (car == null) return Loading();
    //dialog.style(message: 'Please wait...');
    return new Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: // Row(children: <Widget>[Text(car['noplate'])]),
              ListTile(
            leading: CircleAvatar(
                radius: 20.0,
                child: Icon(Icons.directions_car, color: Colors.red),
                backgroundColor: Colors.white),
            title: Text(
              car['noplate'],
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            subtitle: Text(
              car['status'] + 'RM10',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: IconButton(
                icon: Icon(
                  Icons.payment,
                  color: Colors.green,
                ),
                onPressed: () async {
                  await payViaNewCard(
                      context, car.documentID, car['uid'], car['noplate']);

                  // await DatabaseService().updateCarPayment(car.documentID);
                }),
          ),
        ));
  }
}
