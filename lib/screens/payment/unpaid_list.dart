import 'package:flutter/material.dart';
import 'package:parc_app/models/car.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/screens/home/unpaid_tile.dart';
import 'package:parc_app/services/database.dart';
import 'package:parc_app/services/payment_services.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

//Not Applicable
class UnpaidList extends StatefulWidget {
  @override
  _UnpaidListState createState() => _UnpaidListState();
}

class _UnpaidListState extends State<UnpaidList> {
  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response =
        await StripeService.payWithNewCard(amount: '15000', currency: 'USD');
    await dialog.hide();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration:
          new Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<List<Car>>(context) ?? [];
    final user = Provider.of<User>(context);
    //final userData = Provider.of<UserData>(context);

    //print(userData.email);
    return StreamBuilder<List<Car>>(
        stream: DatabaseService(uid: user.uid).unpaidCar,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              return UnpaidTile(car: cars[index]);
            },
          );
        });
  }
}
