import 'package:flutter/material.dart';
import 'package:pokehub/screens/wrapper.dart';
import 'package:pokehub/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:pokehub/models/user_account.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserAccount?>.value(
      catchError: (User, MyUser) => null,
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
