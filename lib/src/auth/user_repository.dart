import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<bool> isAuthenticated();
  Future<void> authenticate();
  Future<User?> getUser();
  Future<void> logout();
  Future<void> signInWithGoogle();
}
