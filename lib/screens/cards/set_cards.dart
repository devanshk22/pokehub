import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokehub/models/user_account.dart';
import 'package:pokehub/screens/cards/pokemon_card_info.dart';
import 'package:pokehub/shared/search_bar.dart';
import 'package:pokehub/size_config.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'package:provider/provider.dart';

class SetListView extends StatefulWidget {
  CardSet set;
  int num_cards;
  SetListView({required this.set, required this.num_cards});

  @override
  _SetListViewState createState() => _SetListViewState();
}

class _SetListViewState extends State<SetListView> {
  final api = PokemonTcgApi(apiKey: '58ad00a8-cb0b-4b71-ae66-7c9829e9b053');
  late final paginatedCardsAll = PaginatedPokemonCards([], api);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAccount>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text(
            widget.set.name,
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
                      widget.num_cards.toString() + " Cards",
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
              FutureBuilder(
                future: api.getCardsForSet(widget.set.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<PokemonCard> set_cards =
                        snapshot.data as List<PokemonCard>;
                    return Expanded(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.num_cards,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              PokemonCard card = set_cards[index];
                              if (card.supertype.type == 'Pokémon') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PokemonCardInfo(
                                              card: set_cards[index],
                                              user: user,
                                            )));
                              } else if (card.supertype.type == 'Trainer') {
                              } else if (card.supertype.type == 'Energy') {}
                            },
                            child: Card(
                              child: Hero(
                                tag: 'card' + set_cards[index].id,
                                child: Image.network(
                                  set_cards[index].images.large,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
