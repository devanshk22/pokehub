import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  late final String uid;

  DatabaseService({required this.uid});

  //collection referrence
  final CollectionReference userData =
      FirebaseFirestore.instance.collection('user_data');

  Future initializeUser(String full_name) async {
    return await userData.doc(uid).set({
      'name': full_name,
      'card_collection': [],
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
}
