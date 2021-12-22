import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokehub/models/user_account.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create UserAccount object from firebase User
  UserAccount? _userFromFirebaseUser(User user) {
    return user != null ? UserAccount(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserAccount?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  //Sign in with Email and Password
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register with Email and Password
  Future createAccount(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

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
