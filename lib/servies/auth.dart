import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login User
  Future<Map> loginUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCred.user != null) {
        // return bool;
        return {"success": true, "user": userCred};
      }
      return {"success": false, "err": "Something went wrong"};
    } on FirebaseAuthException catch (e) {
      print(e);
      return {"success": false, "err": e.message};
    } catch (e) {
      print(e);
      return {"success": false, "err": e.toString()};
    }
  }

  // SignUp User
  Future<Map> signupWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return {"success": true};
    } on FirebaseAuthException catch (e) {
      return {"success": false, "err": e.message};
    } catch (e) {
      return {"success": false, "err": e.toString()};
    }
  }

  Future<bool> signoutUser() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
