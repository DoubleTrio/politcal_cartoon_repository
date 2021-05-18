import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<bool> isAuthenticated();
  Future<void> authenticate();
  Future<String> getUserId();
  Future<void> logout();
  Future<UserCredential> signInWithGoogle();
}
