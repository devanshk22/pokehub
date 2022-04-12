import 'package:flutter/material.dart';
import 'package:pokehub/models/user_account.dart';
import 'package:pokehub/screens/authenticate/authenticate.dart';
import 'package:pokehub/screens/home/home.dart';
import 'package:pokehub/screens/navbar.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  //Return home or authenticate widget
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAccount?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return NavBar();
    }
  }
}
