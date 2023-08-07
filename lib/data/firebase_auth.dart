
import 'package:tourist_guide/data/shared_preference.dart';
import 'package:tourist_guide/models/models.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_guide/data/firebase_repo.dart';

class FirebaseAuthService{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseAuth get firebaseAuth => _firebaseAuth;
  FirebaseRepo _firebaseRepo = FirebaseRepo();

  Future<model.User> createUser(String name, String email, String password, String phone, List<String> langs) async {
    try {
      UserCredential _authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      //create user in database.dart
      SharedPreferenceUtil.changeUserType(SharedPreferenceUtil.touristType);
      model.User _user = model.User(_authResult.user!.uid,name,_authResult.user!.email!,phone, langs);
      if (await _firebaseRepo.createNewUser(_user)) {
        return _user;
      }
      else{
        throw Exception("Error while registering\n ");
      }
    } catch (e) {
      throw Exception("Error while registering\n " + e.toString());
    }
  }

  Future<model.User> login(String email, String password) async {
    try {
      UserCredential _authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      SharedPreferenceUtil.changeUserSessionStatus(SharedPreferenceUtil.loggedIn);
      model.User user = await _firebaseRepo.getUser(_authResult.user!.uid);
      SharedPreferenceUtil.changeUserSessionStatus(SharedPreferenceUtil.loggedIn);
      return user;

    } catch (e) {
          throw Exception("Error while signing in\n " + e.toString());
    }
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      SharedPreferenceUtil.changeUserSessionStatus(SharedPreferenceUtil.loggedOut);
      SharedPreferenceUtil.changeUserType("");
      return true;
    } catch (e) {
      throw Exception("Error while signing out\n " + e.toString());
    }
  }

  Future resetPassword(String email) async{
    try{
      return await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch(e){
     throw Exception(e);
    }
  }


  // get userId of current user
  Future<String> getCurrentUID() async {
    return _firebaseAuth.currentUser!.uid;
  }

  /*FirebaseAuth.instance
  .authStateChanges()
  .listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });*/

}