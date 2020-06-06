import 'package:flutter/material.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/screens/authenticate/authenticate.dart';
import 'package:parc_app/screens/authenticate/testing.dart';
import 'package:parc_app/screens/home/home.dart';
import 'package:parc_app/screens/list_user.dart';
import 'package:parc_app/screens/menu.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return Menu();
    }
  }
}
