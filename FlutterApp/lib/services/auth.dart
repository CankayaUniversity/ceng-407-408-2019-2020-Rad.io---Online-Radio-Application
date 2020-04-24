import 'package:firebase_auth/firebase_auth.dart';
import 'package:tombradioapp/models/user.dart';
import 'package:tombradioapp/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FireBaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream  //to check if user is signed in or "null" signed out
  Stream<User> get user {
    return _auth.onAuthStateChanged
       // .map((FirebaseUser user) => _userFromFirebaseUser(user));
          .map(_userFromFirebaseUser); //same as above
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user); //return uid only instead of useless info
    } catch(e) {
      print(e.toString()); //catches the error
      return null;
    }
  }

  // sign in with email n password
  Future signInWithEmailandPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register with email n password
  Future registerWithEmailandPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //await DatabaseService(uid: user.uid).updateUserData('null',password, 'null'); //ASSIGN NICKNAME IN REGISTER

      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}