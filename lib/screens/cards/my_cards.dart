import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokehub/models/user_account.dart';
import 'package:pokehub/screens/cards/pokemon_card_info.dart';
import 'package:pokehub/services/database_control.dart';
import 'package:pokehub/shared/loading_spinner.dart';
import 'package:pokehub/shared/search_bar.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class MyCards extends StatefulWidget {
  const MyCards({Key? key}) : super(key: key);

  @override
  _MyCardsState createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  final api = PokemonTcgApi(apiKey: '58ad00a8-cb0b-4b71-ae66-7c9829e9b053');
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAccount?>(context);
    return FutureBuilder(
      future: DatabaseService(uid: user!.uid).getUser(),
      builder: (BuildContext context, AsyncSnapshot<UserAccount> userAccount) {
        if (!userAccount.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (userAccount.data!.cardCollection.isEmpty) {
          return Container(
            color: Colors.grey[900],
            child: Center(
              child: Opacity(
                opacity: 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/images/Poke_Ball_icon.png"),
                      width: SizeConfig.blockSizeHorizontal * 30,
                      height: SizeConfig.blockSizeHorizontal * 30,
                    ),
                    Text(
                      "No cards in collection....go buy some and add them through the Database tab!",
                      style: TextStyle(
                        fontFamily: "Blinker",
                        fontSize: SizeConfig.blockSizeHorizontal * 5,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          UserAccount? current_user = userAccount.data;
          return SafeArea(
              child: Scaffold(
            backgroundColor: Colors.grey[900],
            body: Container(
              color: Colors.grey[900],
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 3,
                    ),
                    child: Row(
                      children: [
                        Text(
                          current_user!.cardCollection.length.toString() +
                              " Cards",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Blinker',
                              fontSize: SizeConfig.blockSizeVertical * 3),
                        ),
                        TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.sort,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Sort",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Blinker',
                                  fontSize: SizeConfig.blockSizeVertical * 3),
                            )),
                        TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.filter_alt,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Filter",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Blinker',
                                  fontSize: SizeConfig.blockSizeVertical * 3),
                            )),
                      ],
                    ),
                  ),
                  GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: current_user.cardCollection.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          PokemonCard card = await api
                              .getCard(current_user.cardCollection[index]);
                          if (card.supertype.type == 'Pokémon') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokemonCardInfo(
                                          card: card,
                                          user: user,
                                        )));
                          } else if (card.supertype == 'Trainer') {
                          } else if (card.supertype == 'Energy') {}
                        },
                        child: Card(
                          child: Hero(
                            tag: 'card' + current_user.cardCollection[index],
                            child: Image.network(
                              current_user.cardObjects[index].images.large,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ));
        }
      },
    );
  }
}
