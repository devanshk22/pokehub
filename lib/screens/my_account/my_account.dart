import 'package:flutter/material.dart';
import 'package:pokehub/models/user_account.dart';
import 'package:pokehub/services/database_control.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'package:provider/provider.dart';
import 'package:pokehub/services/auth.dart';

import '../../size_config.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final user = Provider.of<UserAccount?>(context);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () async {
              await _auth.signOut();
            },
            label: Text(
              "Log Out",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        title: Text(
          "Account",
          style: TextStyle(
            fontFamily: "Blinker",
            fontSize: SizeConfig.blockSizeHorizontal * 5,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: DatabaseService(uid: user!.uid).getUser(),
        builder:
            (BuildContext context, AsyncSnapshot<UserAccount> userAccount) {
          if (!userAccount.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            UserAccount? current_user = userAccount.data;
            return Container(
              color: Colors.grey[900],
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage("assets/images/Poke_Ball_icon.png"),
                        width: SizeConfig.blockSizeHorizontal * 30,
                        height: SizeConfig.blockSizeHorizontal * 30,
                      ),
                      Text(
                        "PokéHub",
                        style: TextStyle(
                          fontFamily: "Blinker",
                          fontSize: SizeConfig.blockSizeHorizontal * 8,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Your Account in Numbers",
                        style: TextStyle(
                          fontFamily: "Blinker",
                          fontSize: SizeConfig.blockSizeHorizontal * 5,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      Text(
                        "Name: " + current_user!.name,
                        style: TextStyle(
                          fontFamily: "Blinker",
                          fontSize: SizeConfig.blockSizeHorizontal * 5,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 3),
                      GridView.count(
                        shrinkWrap: true,
                        mainAxisSpacing: SizeConfig.blockSizeVertical * 4,
                        crossAxisSpacing: SizeConfig.blockSizeHorizontal * 4,
                        crossAxisCount: 2,
                        childAspectRatio: 2.0,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical * 1,
                                horizontal: SizeConfig.blockSizeHorizontal * 1),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Number of Cards Collected",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Blinker',
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    current_user.cardCollection.length
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Blinker',
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 4,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical * 1,
                                horizontal: SizeConfig.blockSizeHorizontal * 1),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Number of Decks built",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Blinker',
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    current_user.userDecks.length.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Blinker',
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 4,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical * 1,
                                horizontal: SizeConfig.blockSizeHorizontal * 1),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Number of Cards in Wishlist",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Blinker',
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    current_user.cardWishlist.length.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Blinker',
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 4,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical * 1,
                                horizontal: SizeConfig.blockSizeHorizontal * 1),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Collection Value",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Blinker',
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    getCollectionValue(current_user.cardObjects)
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Blinker',
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 4,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  double getCollectionValue(List<PokemonCard> cards) {
    double sum = 0;
    cards.forEach((element) {
      if (getMarketPrice(element) != "Market Price: Unavailable") {
        double cardPrice = double.parse(getMarketPrice(element));
        sum += cardPrice;
      }
    });
    return sum;
  }

  String getMarketPrice(PokemonCard card) {
    try {
      return card.tcgPlayer["prices"]["normal"]["market"].toString();
    } catch (e) {
      try {
        return card.tcgPlayer["prices"]["holofoil"]["market"].toString();
      } catch (e) {
        return "Market Price: Unavailable";
      }
    }
  }
}
