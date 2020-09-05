import 'package:flutter_bloc_note_app/models/models.dart';
import 'package:flutter_bloc_note_app/repositories/base_repositories.dart';

abstract class BaseAuthRepository extends BaseRepository {
  Future<User> loginAnonymously();
  Future<User> signupWithEmailAndPassword({String email, String password});
  Future<User> loginWithEmailAndPassword({String email, String password});
  Future<User> logout();
  Future<User> getCurrentUser();
  Future<bool> isAnonymous();
}
