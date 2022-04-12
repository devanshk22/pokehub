import 'package:flutter/material.dart';
import 'package:pokehub/models/user_account.dart';
import 'package:pokehub/screens/cards/pokemon_card_info.dart';
import 'package:pokehub/services/auth.dart';
import 'package:pokehub/services/database_control.dart';
import 'package:pokehub/shared/search_bar.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final api = PokemonTcgApi(apiKey: '58ad00a8-cb0b-4b71-ae66-7c9829e9b053');
    final user = Provider.of<UserAccount?>(context);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Home"),
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
          } else if (userAccount.data!.cardWishlist.isEmpty) {
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
                        "No cards in your wishlist.",
                        style: TextStyle(
                          fontFamily: "Blinker",
                          fontSize: SizeConfig.blockSizeHorizontal * 5,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Add Cards to your wishlist to track their prices!",
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
            return Container(
              color: Colors.grey[900],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.blockSizeVertical * 3),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 3,
                    ),
                    child: Text(
                      "My Wishlist",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Blinker',
                          fontSize: SizeConfig.blockSizeVertical * 4),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 3,
                    ),
                    child: Row(
                      children: [
                        Text(
                          current_user!.cardWishlist.length.toString() +
                              "  Cards",
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 3,
                    ),
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: current_user.cardWishlist.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            PokemonCard card = await api
                                .getCard(current_user.cardWishlist[index]);
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
                            child: Column(
                              children: [
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                AspectRatio(
                                  aspectRatio: 3.5 / 2.5,
                                  child: Hero(
                                    tag: 'card' +
                                        current_user.cardWishlist[index],
                                    child: Image.network(
                                      current_user.cardWishlistObjects[index]
                                          .images.small,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                Text(
                                  getMarketPrice(
                                      current_user.cardWishlistObjects[index]),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Blinker',
                                    fontSize: SizeConfig.blockSizeVertical * 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  String getMarketPrice(PokemonCard card) {
    try {
      return r"Market Price:  $" +
          card.tcgPlayer["prices"]["normal"]["market"].toString();
    } catch (e) {
      try {
        return r"Market Price:  $" +
            card.tcgPlayer["prices"]["holofoil"]["market"].toString();
      } catch (e) {
        return "Market Price: Unavailable";
      }
    }
  }
}
