import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  void phone(
    String phone, {
    required Function(PhoneAuthCredential) success,
    required Function(FirebaseAuthException) error,
    required Function(String verificationId) codeSent,
  });

  Future<User> activate({required PhoneAuthCredential phoneAuthCredential});

  void listen({required Function(UserModel?) authStateChanges});

  void logout();
}
