import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokehub/models/deck.dart';
import 'package:pokehub/models/user_account.dart';
import 'package:pokehub/services/database_control.dart';
import 'package:pokehub/shared/search_bar.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../size_config.dart';
import 'deck_view.dart';

class DeckCardSelector extends StatefulWidget {
  String uid;
  String name;
  format deckFormat;
  List<String> deckCards = [];
  DeckCardSelector(
      {required this.uid, required this.name, required this.deckFormat});

  @override
  State<DeckCardSelector> createState() => _DeckCardSelectorState();
}

class _DeckCardSelectorState extends State<DeckCardSelector> {
  String searchQuery = "";
  int num_results = 0;
  final api = PokemonTcgApi(apiKey: '58ad00a8-cb0b-4b71-ae66-7c9829e9b053');
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAccount?>(context);
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Add Cards to " + widget.name),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeVertical * 2,
            vertical: SizeConfig.blockSizeVertical * 2),
        child: Column(
          children: <Widget>[
            SearchBar(
              text: searchQuery,
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              hintText: "Search for a Card",
            ),
            FutureBuilder(
              future: http.get(Uri.parse(
                  'https://api.pokemontcg.io/v2/cards?q=name:$searchQuery*')),
              builder: (BuildContext context, AsyncSnapshot searchCards) {
                if (!searchCards.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (searchQuery == "") {
                  return Center(
                    child: Container(
                      color: Colors.grey[900],
                      child: Center(
                        child: Opacity(
                          opacity: 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(
                                    "assets/images/Poke_Ball_icon.png"),
                                width: SizeConfig.blockSizeHorizontal * 30,
                                height: SizeConfig.blockSizeHorizontal * 30,
                              ),
                              Text(
                                "Enter a search term to search the database. Click on the cards you want and they will be added to your deck!",
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
                    ),
                  );
                } else {
                  Map valueMap = json.decode(searchCards.data.body);
                  List<PokemonCard> results =
                      valueMap['data'].map<PokemonCard>((val) {
                    return PokemonCard.fromJson(val);
                  }).toList();
                  return Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: results.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            PokemonCard card = results[index];
                            widget.deckCards.add(card.id);
                            print(widget.deckCards);
                          },
                          child: Card(
                            child: Hero(
                              tag: 'card' + results[index].id,
                              child: Image.network(
                                results[index].images.large,
                                loadingBuilder: (BuildContext ctx, Widget child,
                                    loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.green),
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (context, obj, stackTrace) {
                                  return Text(
                                      "Error loading image for Card ${results[index].id}");
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeVertical * 2,
            vertical: SizeConfig.blockSizeVertical * 2),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          onPressed: () async {
            final api =
                PokemonTcgApi(apiKey: '58ad00a8-cb0b-4b71-ae66-7c9829e9b053');
            List<PokemonCard> deckCards = await Future.wait(
                widget.deckCards.map((i) async => await api.getCard(i)));
            Deck deck = Deck(
                deckFormat: widget.deckFormat,
                name: widget.name,
                deckList: deckCards);
            DatabaseService(uid: widget.uid).updateDecks(deck);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DeckView(
                          deck: deck,
                          uid: widget.uid,
                        )));
          },
          child: Text(
            "Save Deck",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Blinker",
              fontSize: SizeConfig.blockSizeHorizontal * 4,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
