import 'package:flutter/material.dart';
import 'package:parc_app/screens/car/home_car.dart';
import 'package:parc_app/services/payment_services.dart';

//Not Applicable
void main() => runApp(Payment());

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaymentWidget(),
    );
  }
}

class PaymentWidget extends StatefulWidget {
  @override
  _PaymentWidget createState() => _PaymentWidget();
}

class _PaymentWidget extends State<PaymentWidget> {
  @override
  // void _initSquarePayment() {
  //   InAppPayments.setSquareApplicationId(
  //       'sandbox-sq0idb-9MTD0ZHIqVJrRXBx7WhBcw');
  //   InAppPayments.startCardEntryFlow(
  //     onCardNonceRequestSuccess: _cardNonceRequestSuccess,
  //     onCardEntryCancel: _cardEntryCancel,
  //   );
  // }

  // void _cardEntryCancel() {
  //   Fluttertoast.showToast(msg: "SUCCESS: ", timeInSecForIos: 4);
  // }

  // void _cardNonceRequestSuccess(CardDetails result) {
  //   print(result.nonce);

  //   InAppPayments.completeCardEntry(
  //     onCardEntryComplete: _onCardEntryComplete,
  //   );
  // }

  // void _onCardEntryComplete() {
  //   Fluttertoast.showToast(msg: "SUCCESS: ", timeInSecForIos: 4);
  // }

  // payViaNewCard(BuildContext context) async {
  //   ProgressDialog dialog = new ProgressDialog(context);
  //   dialog.style(message: 'Please wait...');
  //   await dialog.show();
  //   var response =
  //       await StripeService.payWithNewCard(amount: '15000', currency: 'USD');
  //   await dialog.hide();
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //     content: Text(response.message),
  //     duration:
  //         new Duration(milliseconds: response.success == true ? 1200 : 3000),
  //   ));
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   StripeService.init();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Payment')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => null, //payViaNewCard(context),
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}
