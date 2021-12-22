import 'package:flutter/material.dart';
import 'package:pokehub/screens/authenticate/text_field_decoration.dart';
import 'package:pokehub/size_config.dart';
import 'package:pokehub/services/auth.dart';

class SignIn extends StatefulWidget {
  late final Function toggleView;

  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  //text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/Poke_Ball_icon.png"),
                width: SizeConfig.blockSizeHorizontal * 40,
                height: SizeConfig.blockSizeHorizontal * 40,
              ),
              Text(
                "PokéHub",
                style: TextStyle(
                  fontFamily: "Blinker",
                  fontSize: SizeConfig.blockSizeHorizontal * 10,
                  color: Colors.white,
                ),
              ),
              Text(
                "Log in to your account",
                style: TextStyle(
                  fontFamily: "Blinker",
                  fontSize: SizeConfig.blockSizeHorizontal * 6,
                  color: Colors.white,
                ),
              ),
              Form(
                key: _formkey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeVertical * 4,
                      vertical: SizeConfig.blockSizeVertical * 4),
                  child: Column(
                    children: <Widget>[
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
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter an email ID' : null,
                        style: input_text_style.copyWith(color: Colors.black),
                        decoration: decor.copyWith(hintText: "Email ID"),
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
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your password'
                            : null,
                        style: input_text_style.copyWith(color: Colors.black),
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
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              dynamic result =
                                  await _auth.signIn(email, password);
                              if (result == null) {
                                setState(() {
                                  error = "Please supply valid credentials";
                                });
                              }
                            }
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Blinker",
                              fontSize: SizeConfig.blockSizeHorizontal * 4,
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
                          "Don't have an account? Sign up today for free!",
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
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          onPressed: () {
                            widget.toggleView();
                          },
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Blinker",
                              fontSize: SizeConfig.blockSizeHorizontal * 4,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
