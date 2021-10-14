import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/repositories/auth_repository.dart';

class AuthUseCase {
  AuthRepository authRepository;

  AuthUseCase({required this.authRepository});

  Future<void> call(
    String phone, {
    required Function(PhoneAuthCredential) success,
    required Function(FirebaseAuthException) error,
    required Function(String verificationId) codeSent,
  }) async {
    authRepository.phone(
      phone,
      codeSent: codeSent,
      error: error,
      success: success,
    );
  }
}
