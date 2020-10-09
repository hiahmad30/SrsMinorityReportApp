import 'package:firebase_auth/firebase_auth.dart';
import 'package:minorityreport/Utils/Consts.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);

  Future<String> createUserWithEmailAndPassword(String email, String password);

  Future<void> currentUser();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
  //       (FirebaseUser user) => user?.uid,
  //     );

  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    final FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password)) as FirebaseUser;
    return user?.uid;
  }

  @override
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    final FirebaseUser user = (await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password))
        as FirebaseUser;
    return user?.uid;
  }

  @override
  Future<void> currentUser() async {
    final FirebaseUser user = (await _firebaseAuth.currentUser) as FirebaseUser;
    u_id= user?.uid;
  }

  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser).uid;
  }

  Future getCurrentUser() async {
    return await _firebaseAuth.currentUser;
  }
}
