import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/screens/profile/change_contact.dart';
import 'package:parc_app/screens/profile/change_password.dart';
import 'package:parc_app/screens/profile/edit_name.dart';
import 'package:parc_app/screens/shared/loading.dart';
import 'package:parc_app/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(Profile());

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileWidget(),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final AuthService _auth = AuthService();
  File sampleImage;
  String filename;

  // Future _getImage() async {
  //   var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     sampleImage = tempImage;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    void _editName() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: EditName(),
          );
        },
        isScrollControlled: true,
      );
    }

    void _changePassword() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: ChangePassword(),
          );
        },
        isScrollControlled: true,
      );
    }

    void _changeContact() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: ChangeContact(),
          );
        },
        isScrollControlled: true,
      );
    }

    return Scaffold(
      appBar: new AppBar(
        title: Center(
          child: Text(
            'Profile',
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
              .collection('users')
              .document(user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Loading();
            }
            return Padding(
              padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Divider(
                    height: 60.0,
                    color: Colors.grey[800],
                  ),
                  // Center(
                  //   child: sampleImage == null
                  //       ? Text('Select an image')
                  //       : enableUpload(),
                  //   // CircleAvatar(
                  //   //   backgroundImage: AssetImage(''),
                  //   //   radius: 80.0,
                  //   // ),
                  // ),
                  // Center(
                  //     child: IconButton(
                  //         icon: Icon(
                  //           Icons.add_a_photo,
                  //           color: Colors.green,
                  //         ),
                  //         onPressed: () {
                  //           ;
                  //         }
                  //         // onPressed: () async {
                  //         //   final StorageReference firebaseStorageRef =
                  //         //       FirebaseStorage.instance
                  //         //           .ref()
                  //         //           .child('image.jpg');
                  //         //   final StorageUploadTask task =
                  //         //       firebaseStorageRef.putFile(sampleImage);
                  //         // }
                  //         )),
                  // Divider(
                  //   height: 60.0,
                  //   color: Colors.grey[800],
                  // ),
                  Text(
                    'Info',
                    style: TextStyle(
                      fontFamily: 'Montserrat-bold',
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[900],
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.account_circle,
                            color: Colors.blue[400],
                          ),
                          onPressed: () {
                            _editName();
                          }),
                      Text(
                        snapshot.data['name'],
                        style: TextStyle(
                            //color: Colors.grey[400],
                            fontSize: 16.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    children: <Widget>[
                      Icon(Icons.email, color: Colors.blue[400]),
                      SizedBox(width: 10.0),
                      Text(
                        snapshot.data['email'],
                        style: TextStyle(
                            //color: Colors.grey[400],
                            fontSize: 16.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0),
                      )
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.stay_primary_portrait,
                            color: Colors.blue[400],
                          ),
                          onPressed: () {
                            _changeContact();
                          }),
                      Text(
                        snapshot.data['contact'],
                        style: TextStyle(
                            //color: Colors.grey[400],
                            fontSize: 16.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0),
                      ),
                    ],
                  ),

                  Divider(
                    height: 60.0,
                    color: Colors.grey[800],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Change Password',
                        style: TextStyle(
                            //color: Colors.yellow,
                            fontSize: 12.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.vpn_key,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _changePassword();
                        },
                      ),
                    ],
                  ),
                  FlatButton.icon(
                    color: Colors.red,
                    icon: Icon(Icons.cancel, color: Colors.white),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    label: Text(
                      'Log out',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Montserrat'),
                    ),
                  ),
                ],
              ),
            );
          }),
      //     body: new Stack(
      //   children: <Widget>[
      //     ClipPath(
      //       child: Container(color: Colors.indigo[900]),
      //       clipper: getClipper(),
      //     ),
      //     Positioned(
      //         width: 400.0,
      //         top: MediaQuery.of(context).size.height / 5,
      //         child: Column(
      //           children: <Widget>[
      //             Container(
      //                 width: 150.0,
      //                 height: 150.0,
      //                 decoration: BoxDecoration(
      //                     color: Colors.indigo[900],
      //                     image: DecorationImage(
      //                         image: NetworkImage(
      //                             'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
      //                         fit: BoxFit.cover),
      //                     borderRadius: BorderRadius.all(Radius.circular(75.0)),
      //                     boxShadow: [
      //                       BoxShadow(blurRadius: 7.0, color: Colors.black)
      //                     ])),
      //             SizedBox(height: 90.0),
      //             Text(
      //               'Tom Cruise',
      //               style: TextStyle(
      //                   fontSize: 30.0,
      //                   fontWeight: FontWeight.bold,
      //                   fontFamily: 'Montserrat'),
      //             ),
      //             SizedBox(height: 25.0),
      //             Container(
      //                 height: 50.0,
      //                 width: 150.0,
      //                 child: Material(
      //                   borderRadius: BorderRadius.circular(20.0),
      //                   shadowColor: Colors.redAccent,
      //                   color: Colors.red[600],
      //                   elevation: 7.0,
      //                   child: GestureDetector(
      //                     onTap: () {},
      //                     child: Center(
      //                       child: FlatButton.icon(
      //                         icon: Icon(Icons.cancel, color: Colors.white),
      //                         onPressed: () async {
      //                           await _auth.signOut();
      //                         },
      //                         label: Text(
      //                           'Log out',
      //                           style: TextStyle(
      //                               color: Colors.white,
      //                               fontFamily: 'Montserrat'),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 )),
      //             SizedBox(height: 25.0),
      //             Container(
      //                 height: 50.0,
      //                 width: 150.0,
      //                 child: Material(
      //                   borderRadius: BorderRadius.circular(20.0),
      //                   shadowColor: Colors.redAccent,
      //                   color: Colors.red[600],
      //                   elevation: 7.0,
      //                   child: GestureDetector(
      //                     onTap: () {},
      //                     child: Center(
      //                       child: FlatButton.icon(
      //                         icon: Icon(Icons.cancel, color: Colors.white),
      //                         onPressed: () async {
      //                           await _auth.signOut();
      //                         },
      //                         label: Text(
      //                           'Log out',
      //                           style: TextStyle(
      //                               color: Colors.white,
      //                               fontFamily: 'Montserrat'),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ))
      //           ],
      //         ))
      //   ],
      // )
    );
  }

  // Widget enableUpload() {
  //   return Container(
  //     child: Column(children: <Widget>[
  //       Image.file(sampleImage, height: 300.0, width: 300.0)
  //     ]),
  //   );
  // }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
