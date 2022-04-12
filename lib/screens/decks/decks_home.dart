import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokehub/models/user_account.dart';
import 'package:pokehub/screens/decks/deck_info_form.dart';
import 'package:pokehub/services/auth.dart';
import 'package:pokehub/services/database_control.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../size_config.dart';

class DeckTab extends StatefulWidget {
  const DeckTab({Key? key}) : super(key: key);

  @override
  _DeckTabState createState() => _DeckTabState();
}

class _DeckTabState extends State<DeckTab> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAccount?>(context);
    return FutureBuilder(
      future: DatabaseService(uid: user!.uid).getUser(),
      builder: (BuildContext context, AsyncSnapshot<UserAccount> userAccount) {
        if (!userAccount.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          UserAccount? currentUser = userAccount.data;
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.white,
              icon: const Icon(
                Icons.add,
                color: Colors.red,
              ),
              label: Text(
                "New Deck",
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Blinker',
                  fontSize: SizeConfig.blockSizeVertical * 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeckInfoForm(uid: user.uid)));
              },
            ),
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              title: Text(currentUser!.name + "'s" + " Decks"),
              backgroundColor: Colors.red,
              elevation: 0.0,
            ),
            body: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding:
                    EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.5),
                children:
                    //Map deckMap = jsonDecode(e);
                    [
                  ListTile(
                    enabled: true,
                    onTap: () {},
                    title: Text(
                      "RS Malamar / Inteleon",
                      style: TextStyle(
                        fontFamily: "Blinker",
                        fontSize: SizeConfig.blockSizeHorizontal * 5,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                    ),
                  ),
                  ListTile(
                    enabled: true,
                    onTap: () {},
                    title: Text(
                      "Arceus VSTAR / Galarian Birds",
                      style: TextStyle(
                        fontFamily: "Blinker",
                        fontSize: SizeConfig.blockSizeHorizontal * 5,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                    ),
                  ),
                ]),
          );
        }
      },
    );
  }

  // getData() async {
  //   String userId = (await FirebaseAuth.instance.currentUser()).uid;
  //   return FirebaseFirestore.instance.collection('user_data').doc();
  // }
}
