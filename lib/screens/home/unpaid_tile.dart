import 'package:flutter/material.dart';
import 'package:parc_app/models/car.dart';
import 'package:parc_app/services/payment_services.dart';
import 'package:progress_dialog/progress_dialog.dart';

//Not Applicable
class UnpaidTile extends StatelessWidget {
  final Car car;
  UnpaidTile({this.car});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(radius: 25.0, backgroundColor: Colors.indigo),
          title: Text(car.status),
          subtitle: Text(car.noplate),
          trailing: Wrap(children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.yellow[800],
                ),
                onPressed: () => null)
          ]),
        ),
      ),
    );
  }
}
