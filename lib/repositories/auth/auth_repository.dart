import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc_note_app/config/paths.dart';
import 'package:flutter_bloc_note_app/entity/entities.dart';
import 'package:flutter_bloc_note_app/models/user_model.dart';
import 'package:flutter_bloc_note_app/repositories/repositories.dart';

class AuthRepository extends BaseAuthRepository {
  final Firestore _firestore;
  final FirebaseAuth _firebaseAuth;
  AuthRepository({Firestore firestore, FirebaseAuth firebaseAuth})
      : _firestore = firestore ?? Firestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  void dispose() {}

  Future<User> _firebaseUserToUser(FirebaseUser user) async {
    DocumentSnapshot userDoc =
        await _firestore.collection(Paths.users).document(user.uid).get();
    if (userDoc.exists) {
      User user = User.fromEntity(UserEntity.fromSnapshot(userDoc));
      return user;
    }
    return User(id: user.uid, email: '');
  }

  @override
  Future<User> loginAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return await _firebaseUserToUser(authResult.user);
  }

  @override
  Future<User> getCurrentUser() {}

  @override
  Future<bool> isAnonymous() {}

  @override
  Future<User> loginWithEmailAndPassword({String email, String password}) {}

  @override
  Future<User> logout() {}

  @override
  Future<User> signupWithEmailAndPassword({String email, String password}) {}
}
