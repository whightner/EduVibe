import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 🔹 Returns the current logged-in user, or null if no user is signed in.
  Future<User?> getCurrentUser() async {
    try {
      return _auth.currentUser;
    } catch (e) {
      debugPrint("Error retrieving current user: $e");
      return null;
    }
  }

  /// 🔹 Signs up a user with email and password.
  /// Returns the `User` object if successful, otherwise `null`.
  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("User signed up: ${userCredential.user?.email}");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase Auth Error (Sign Up): ${e.message}");
      return null;
    } catch (e) {
      debugPrint("Unexpected error (Sign Up): $e");
      return null;
    }
  }

  /// 🔹 Signs in a user with email and password.
  /// Returns the `User` object if authentication is successful, otherwise `null`.
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("User signed in: ${userCredential.user?.email}");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase Auth Error (Sign In): ${e.message}");
      return null;
    } catch (e) {
      debugPrint("Unexpected error (Sign In): $e");
      return null;
    }
  }

  /// 🔹 Signs out the current user.
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      debugPrint("User signed out successfully.");
    } catch (e) {
      debugPrint("Error signing out: $e");
    }
  }
}
