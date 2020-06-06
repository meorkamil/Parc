import 'package:flutter/material.dart';
import 'package:parc_app/screens/shared/constants.dart';
import 'package:parc_app/screens/shared/loading.dart';
import 'package:parc_app/services/auth.dart';
import 'package:parc_app/Animation/FadeAnimation.dart';

class Register extends StatefulWidget {
  final Function toogleView;
  Register({this.toogleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/1.png"),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(
                        1,
                        Text(
                          "Join Parc, \nExperience it",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      FadeAnimation(
                        1,
                        Form(
                          key: _formKey,
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.transparent,
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                      style: TextStyle(color: Colors.grey[600]),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                      validator: (val) =>
                                          val.isEmpty ? 'Enter an email' : null,
                                      onChanged: (val) {
                                        setState(() => email = val);
                                      }),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                      style: TextStyle(color: Colors.grey[600]),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[600])),
                                      validator: (val) => val.length < 6
                                          ? 'Enter a password 6+ char long'
                                          : null,
                                      obscureText: true,
                                      onChanged: (val) {
                                        setState(() => password = val);
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: FadeAnimation(
                          1,
                          Text(
                            error,
                            style: TextStyle(
                              color: Colors.red[200],
                            ),
                          ),
                        ),
                      ),
                      FadeAnimation(
                        1,
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.indigo[800],
                          ),
                          child: Center(
                            child: FlatButton.icon(
                                icon: Icon(Icons.add, color: Colors.white),
                                label: Text(
                                  "Join Us",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        error = "Please supply a valid email";
                                        loading = false;
                                      });
                                    }
                                  }
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      FadeAnimation(
                        1,
                        Center(
                          child: FlatButton.icon(
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Colors.green[800],
                            ),
                            onPressed: () {
                              widget.toogleView();
                            },
                            label: Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.green[800],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
    // : Scaffold(
    //     backgroundColor: Colors.white,
    //     appBar: AppBar(
    //       backgroundColor: Colors.indigo,
    //       elevation: 0.0,
    //       title: Text('Join Parc'),
    //       actions: <Widget>[
    //         FlatButton.icon(
    //           icon: Icon(
    //             Icons.exit_to_app,
    //             color: Colors.white,
    //           ),
    //           label: Text(
    //             'Sign in',
    //             style: TextStyle(color: Colors.white),
    //           ),
    //           onPressed: () {
    //             widget.toogleView();
    //           },
    //         )
    //       ],
    //     ),
    //     body: Container(
    //         padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
    //         // child: RaisedButton(
    //         //   child: Text('Sign in anon'),
    //         //   onPressed: () async {
    //         //     dynamic result = await _auth.signInAnon();
    //         //     if (result == null) {
    //         //       print('error signing in');
    //         //     } else {
    //         //       print('signed in');
    //         //       print(result.uid);
    //         //     }
    //         //   },
    //         // )
    //         child: Form(
    //             key: _formKey,
    //             child: Column(children: <Widget>[
    //               SizedBox(
    //                 height: 20.0,
    //               ),
    //               TextFormField(
    //                   decoration:
    //                       textInputDecoration.copyWith(hintText: 'Email'),
    //                   validator: (val) =>
    //                       val.isEmpty ? 'Enter an email' : null,
    //                   onChanged: (val) {
    //                     setState(() => email = val);
    //                   }),
    //               SizedBox(
    //                 height: 20.0,
    //               ),
    //               TextFormField(
    //                   decoration: textInputDecoration.copyWith(
    //                       hintText: 'Password'),
    //                   validator: (val) => val.length < 6
    //                       ? 'Enter a password 6+ char long'
    //                       : null,
    //                   obscureText: true,
    //                   onChanged: (val) {
    //                     setState(() => password = val);
    //                   }),
    //               SizedBox(
    //                 height: 20.0,
    //               ),
    //               RaisedButton(
    //                   color: Colors.pink[400],
    //                   child: Text('Register',
    //                       style: TextStyle(color: Colors.white)),
    //                   onPressed: () async {
    //                     if (_formKey.currentState.validate()) {
    //                       setState(() => loading = true);
    //                       dynamic result =
    //                           await _auth.registerWithEmailAndPassword(
    //                               email, password);
    //                       if (result == null) {
    //                         setState(() {
    //                           error = "Please supply a valid email";
    //                           loading = false;
    //                         });
    //                       }
    //                     }
    //                   }),
    //               SizedBox(height: 12.0),
    //               Text(error,
    //                   style: TextStyle(color: Colors.red, fontSize: 14.0))
    //             ]))),
    //   );
  }
}
