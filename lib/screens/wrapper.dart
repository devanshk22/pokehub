import 'package:flutter/material.dart';
import 'package:pokehub/screens/authenticate/authenticate.dart';
import 'package:pokehub/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  //Return home or authenticate widget

  @override
  Widget build(BuildContext context) {
    return Authenticate();
  }
}
