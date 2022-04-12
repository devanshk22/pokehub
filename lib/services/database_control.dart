import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokehub/models/deck.dart';
import 'package:pokehub/models/user_account.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'dart:convert';

class DatabaseService {
  late final String uid;

  DatabaseService({required this.uid});

  //collection referrence
  final CollectionReference userData =
      FirebaseFirestore.instance.collection('user_data');

  Future initializeUser(String full_name, String email) async {
    return await userData.doc(uid).set({
      'name': full_name,
      'email': email,
      'card_collection': [],
      'card_wishlist': [],
      'decks': [],
      'collections': [],
    });
  }

  Future updateCardCollection(String cardID, bool toAdd) async {
    if (cardID == "") {
      return await userData.doc(uid).update({});
    } else if (toAdd) {
      return await userData.doc(uid).update({
        'card_collection': FieldValue.arrayUnion([cardID])
      });
    } else {
      return await userData.doc(uid).update({
        'card_collection': FieldValue.arrayRemove([cardID])
      });
    }
  }

  Future updateCardWishlist(String cardID, bool toAdd) async {
    if (cardID == "") {
      return await userData.doc(uid).update({});
    } else if (toAdd) {
      return await userData.doc(uid).update({
        'card_wishlist': FieldValue.arrayUnion([cardID])
      });
    } else {
      return await userData.doc(uid).update({
        'card_wishlist': FieldValue.arrayRemove([cardID])
      });
    }
  }

  Future updateDecks(Deck deck) async {
    //return await userData.doc(uid).collection("user_decks").add(deck.toMap());
    return await userData.doc(uid).update({
      'decks': FieldValue.arrayUnion([deck.toMapString()]),
    });
  }

  // card list from snapshot
  List<UserAccount> _userDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      return UserAccount(
        uid: uid,
      );
    }).toList();
  }

  Stream<List<UserAccount>> get userDataSnapshot {
    return userData.snapshots().map(_userDataFromSnapshot);
  }

  Future<Object?> _getDocument(
          CollectionReference collection, String id) async =>
      await collection.doc(id).get().then((snapshot) => snapshot.data());

  Future<List> getUserCards(String uid) async {
    // Get user information
    Map userMapData = await _getDocument(userData, uid) as Map;
    print(userMapData);
    DocumentReference userDocRef = userData.doc(uid);

    // Get favourites
    List cards = userMapData['card_collection'];

    return cards;
  }

  Future<UserAccount> getUser() async {
    final api = PokemonTcgApi(apiKey: '58ad00a8-cb0b-4b71-ae66-7c9829e9b053');
    // Get user information
    Map userMapData = await _getDocument(userData, uid) as Map;

    DocumentReference userDocRef = userData.doc(uid);

    // Get favourites
    List cards = [];
    List cards_wishlist = [];
    List<PokemonCard> card_objs = [];
    List<PokemonCard> card_wishlist_objs = [];
    List user_decks = [];
    if (userMapData['card_collection'] == null) {
      cards = [];
      card_objs = [];
    } else {
      cards = userMapData['card_collection'];
      card_objs =
          await Future.wait(cards.map((i) async => await api.getCard(i)));
    }
    if (userMapData['card_wishlist'] == null) {
      cards_wishlist = [];
      card_wishlist_objs = [];
    } else {
      cards_wishlist = userMapData['card_wishlist'];
      card_wishlist_objs = await Future.wait(
          cards_wishlist.map((i) async => await api.getCard(i)));
    }
    if (userMapData['decks'] == null) {
      user_decks = [];
    } else {
      user_decks = userMapData['decks'];
    }

    return UserAccount.fromJson(
        uid, userMapData, card_objs, card_wishlist_objs);
  }

  Future<DocumentSnapshot> getUserDoc() async {
    return userData.doc(uid).get();
  }
}
