import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokehub/models/user_account.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create UserAccount object from firebase User
  UserAccount? _userFromFirebaseUser(User user) {
    return user != null ? UserAccount(uid: user.uid) : null;
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //auth change user stream
  Stream<UserAccount?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  //Sign in with Email and Password

  //Register with Email and Password

  //Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
