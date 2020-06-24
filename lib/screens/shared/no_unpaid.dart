import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class NoUnpaid extends StatelessWidget {
  _launchURL() async {
    const url = 'tel://0135071614';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Start Parking Now',
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'Montserrat-bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 10.0),
              Divider(
                height: 10.0,
                color: Colors.grey[800],
              ),
              SizedBox(height: 5.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Need Help?',
                      style: TextStyle(
                        fontFamily: 'Montserrat-bold',
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.call),
                      color: Colors.deepOrange,
                      onPressed: () {
                        _launchURL();
                      },
                    ),

                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(8.0),
                    //   child: Image.asset(
                    //     'assets/images/stripe.png',
                    //     width: 140.0,
                    //     height: 40.0,
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    // SizedBox(height: 10.0),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(8.0),
                    //   child: Image.asset(
                    //     'assets/images/flutter.png',
                    //     width: 110.0,
                    //     height: 28.0,
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                  ])
            ]));
  }
}
