import 'dart:convert';

import 'package:pokemon_tcg/pokemon_tcg.dart';

enum format { Standard, Expanded, Legacy, Unlimited, GLC }

class Deck {
  late String name;
  late format deckFormat;
  late List<PokemonCard> deckList;
  bool complete = false;

  Deck({
    required this.name,
    required this.deckFormat,
    required this.deckList,
  });

  Future<void> setDeck(List<String> cards) async {
    final api = PokemonTcgApi(apiKey: '58ad00a8-cb0b-4b71-ae66-7c9829e9b053');
    deckList = await Future.wait(cards.map((i) async => await api.getCard(i)));
  }

  String toMapString() {
    // return jsonEncode({
    //   'name': name,
    //   'format': deckFormat.toString().split('.').last,
    //   'decklist': deckList.map((e) => e.id),
    //   'complete': deckList.length == 60 ? true : false,
    // });
    return """{'name': $name, 'format': ${deckFormat.toString().split('.').last}, 'decklist': ${deckList.map((e) => e.id)}, 'complete': ${deckList.length == 60 ? true : false}}""";
  }
}
