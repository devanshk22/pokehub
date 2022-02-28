import 'package:flutter/material.dart';
import 'package:pokehub/screens/cards/card_database.dart';
import 'package:pokehub/screens/cards/my_cards.dart';
import 'package:pokehub/screens/cards/set_cards.dart';
import 'package:pokehub/shared/search_bar.dart';
import 'package:pokehub/size_config.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';

class CardTab extends StatefulWidget {
  const CardTab({Key? key}) : super(key: key);

  @override
  _CardTabState createState() => _CardTabState();
}

class _CardTabState extends State<CardTab> {
  final api = PokemonTcgApi(apiKey: '58ad00a8-cb0b-4b71-ae66-7c9829e9b053');
  late final paginatedCardsAll = PaginatedPokemonCards([], api);
  int results = 0;
  String search_term = " ";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize:
                  Size(double.infinity, SizeConfig.blockSizeVertical * 100),
              child: TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                labelStyle: TextStyle(
                  fontFamily: "Blinker",
                  fontSize: SizeConfig.blockSizeHorizontal * 5,
                  color: Colors.white,
                ),
                tabs: [
                  Tab(
                    text: "Card Database",
                  ),
                  Tab(
                    text: "My Cards",
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.red,
            body: TabBarView(
              children: [
                Container(
                  color: Colors.grey[900],
                  child: FutureBuilder(
                    future: api.getSets(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        List<CardSet> sets = snapshot.data as List<CardSet>;
                        return ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 0.5),
                          children: sets
                              .map((e) => ListTile(
                                    enabled: true,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SetListView(
                                                    set: e,
                                                    num_cards: e.total,
                                                  )));
                                    },
                                    title: Text(
                                      e.name,
                                      style: TextStyle(
                                        fontFamily: "Blinker",
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Colors.white,
                                    ),
                                  ))
                              .toList(),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                Container(
                  color: Colors.green,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
