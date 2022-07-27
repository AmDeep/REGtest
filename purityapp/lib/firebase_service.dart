import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FbService {
  FbService._privateConstructor();

  static final FbService instance = FbService._privateConstructor();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String? get userid =>
      _auth.currentUser == null ? null : _auth.currentUser?.uid;

  User? get currentUser => _auth.currentUser != null ? _auth.currentUser : null;

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
   try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
  }

  Future<void> signUpFirebaseUser(
      String name, String email, String password) async {
    try {
      if (_auth.currentUser == null) {
        print("what is hpaenn");
        await createFirebaseUser(name, email, password);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createFirebaseUser(
      String name, String email, String password) async {
    try {
      await createUserWithEmailAndPassword(email, password);
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        await createFirestoreUserData(name, email, uid);
      }
    } catch (e) {
      throw "$e";
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

//USER METRIC ANSWERS HERE
  Future<void> createFirestoreUserData(
      String name, String email, String uid) async {
    try {
      final result = await _db.collection(FirebaseConstants.users).add(
        {
          FirebaseConstants.name: name,
          FirebaseConstants.email: email,
          FirebaseConstants.uid: uid,
          FirebaseConstants.date: DateTime.now().toUtc().toIso8601String()
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteListingData(String docId) async {
    try {
      await _db.collection(FirebaseConstants.listing).doc(docId).delete();
    } catch (e) {
      throw "$e";
    }
  }
}

//USER METRICS HERE
class FirebaseConstants {
  static const String users = 'users';
  static const String name = 'name';
  static const String email = 'email';
  static const String uid = 'uid';
  static const String date = 'date';
  static const String listing = 'listing';
  static const String escrow = 'escrow';
}
