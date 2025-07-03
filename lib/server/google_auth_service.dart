import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

const String clientId =
    '672973784855-75vq23r989ujkgh589q0ra27jcgm9uet.apps.googleusercontent.com';
const String serverClientId =
    '672973784855-75vq23r989ujkgh589q0ra27jcgm9uet.apps.googleusercontent.com';

final GoogleSignIn signIn = GoogleSignIn.instance;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Firebase registration error: $e");
      rethrow;
    }
  }
  // google bilan sigin qilish metodi
  Future<User?> signInWithGoogle() async {
    try {
      await signIn.initialize(
        clientId: clientId,
        serverClientId: serverClientId,
      );

      final account = await signIn.authenticate();
      if (account == null) return null;

      final credential = GoogleAuthProvider.credential(
        idToken: account.authentication.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Google Sign-In error: $e");
      rethrow;
    }
  }



  // parolni tiklash metodi


  Future<void> sendPasswordResetEmail(String email) async {
  try {
    await _auth.sendPasswordResetEmail(email: email.trim());
    print("Reset email sent to $email");
  } catch (e) {
    print("Password reset error: $e");
    rethrow;
  }
}


}
