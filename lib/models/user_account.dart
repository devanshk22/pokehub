import 'package:pokehub/models/card.dart';
import 'package:pokehub/models/card_collection.dart';
import 'package:pokehub/models/deck.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'dart:convert';

class UserAccount {
  late final String uid;
  String name = "";
  String email = "";
  List<String> cardCollection = [];
  List<PokemonCard> cardObjects = [];
  List<String> cardWishlist = [];
  List<PokemonCard> cardWishlistObjects = [];
  List userDecks = [];
  List<CardCollection> userCollections = [];

  UserAccount({
    required this.uid,
  });

  UserAccount.fromJson(String uid, Map json, List<PokemonCard> cardobjs,
      List<PokemonCard> cardWishlistObjs) {
    final api = PokemonTcgApi(apiKey: '58ad00a8-cb0b-4b71-ae66-7c9829e9b053');
    this.uid = uid;
    name = json['name'] as String;
    List<String> cards = json['card_collection'].cast<String>();
    List<String> cardwish = json['card_wishlist'].cast<String>();
    List<String> user_decks = json['decks'].cast<String>();
    userDecks = user_decks.map((e) => jsonDecode(e)).toList();
    cardCollection = cards;
    cardWishlist = cardwish;
    cardObjects = cardobjs;
    cardWishlistObjects = cardWishlistObjs;
  }
}
