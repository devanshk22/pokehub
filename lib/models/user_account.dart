import 'package:pokehub/models/card.dart';
import 'package:pokehub/models/card_collection.dart';
import 'package:pokehub/models/deck.dart';

class UserAccount {
  late final String uid;
  String name = "";
  String email = "";
  List<Card> cardCollection = [];
  List<Deck> userDecks = [];
  List<CardCollection> userCollections = [];

  UserAccount({required this.uid});
}
