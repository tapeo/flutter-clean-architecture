import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> phone(
    String phone, {
    required Function(PhoneAuthCredential) success,
    required Function(FirebaseAuthException) error,
    required Function(String verificationId) codeSent,
  });

  Future<User> activate({required PhoneAuthCredential phoneAuthCredential});
}
