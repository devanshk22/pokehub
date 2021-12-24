import 'package:flutter/material.dart';
import 'package:pokehub/screens/authenticate/text_field_decoration.dart';
import 'package:pokehub/services/auth.dart';
import 'package:pokehub/shared/loading_spinner.dart';

import '../../size_config.dart';

class Register extends StatefulWidget {
  late final Function toggleView;

  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String name = "";
  String email = "";
  String password = "";
  String confirm_password = "";
  String error = " ";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[900],
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeVertical * 4,
                      vertical: SizeConfig.blockSizeVertical * 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "PokéHub",
                            style: TextStyle(
                              fontFamily: "Blinker",
                              fontSize: SizeConfig.blockSizeHorizontal * 10,
                              color: Colors.white,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Image(
                              image: AssetImage(
                                  "assets/images/Poke_Ball_icon.png"),
                              width: SizeConfig.blockSizeHorizontal * 25,
                              height: SizeConfig.blockSizeHorizontal * 25,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Join PokéHub today!",
                          style: TextStyle(
                            fontFamily: "Blinker",
                            fontSize: SizeConfig.blockSizeHorizontal * 6,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Name",
                                style: TextStyle(
                                  fontFamily: "Blinker",
                                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? 'Please enter a name' : null,
                              style: input_text_style.copyWith(
                                  color: Colors.black),
                              decoration: decor.copyWith(hintText: "Name"),
                              onChanged: (val) {
                                setState(() => name = val);
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Email ID",
                                style: TextStyle(
                                  fontFamily: "Blinker",
                                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            TextFormField(
                              validator: (val) => val!.isEmpty
                                  ? 'Please enter an email ID'
                                  : null,
                              style: input_text_style.copyWith(
                                  color: Colors.black),
                              decoration: decor.copyWith(
                                hintText: "Email ID",
                              ),
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Password",
                                style: TextStyle(
                                  fontFamily: "Blinker",
                                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            TextFormField(
                              validator: (val) => val!.length < 8
                                  ? 'Please enter a password with 8 or more characters'
                                  : null,
                              style: input_text_style.copyWith(
                                  color: Colors.black),
                              decoration: decor.copyWith(
                                hintText: "Password",
                              ),
                              obscureText: true,
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Confirm Password",
                                style: TextStyle(
                                  fontFamily: "Blinker",
                                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            TextFormField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please confirm password";
                                } else if (val != password) {
                                  return 'Passwords do not match';
                                } else {
                                  return null;
                                }
                              },
                              style: input_text_style.copyWith(
                                  color: Colors.black),
                              decoration: decor.copyWith(
                                hintText: "Confirm Password",
                              ),
                              obscureText: true,
                              onChanged: (val) {
                                setState(() => confirm_password = val);
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                ),
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() => loading = true);
                                    dynamic result = await _auth.createAccount(
                                        name, email, password);
                                    if (!mounted) return;
                                    if (result == null) {
                                      setState(() {
                                        error = "Please supply a valid email";
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Blinker",
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              error,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Blinker",
                                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                                  color: Colors.red),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            Row(children: <Widget>[
                              Expanded(
                                  child: Divider(
                                color: Colors.white,
                              )),
                              Text(
                                "Already have an account? Sign in now!",
                                style: TextStyle(
                                  fontFamily: "Blinker",
                                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                color: Colors.white,
                              )),
                            ]),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  widget.toggleView();
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Blinker",
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
