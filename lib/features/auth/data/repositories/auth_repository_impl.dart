import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/data/datasources/auth_datasource.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  const AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<void> phone(
    String phone, {
    required Function(PhoneAuthCredential) success,
    required Function(FirebaseAuthException) error,
    required Function(String verificationId) codeSent,
  }) async {
    authDataSource.authPhone(
      phone,
      codeSent: codeSent,
      error: error,
      success: success,
    );
  }

  @override
  Future<User> activate(
      {required PhoneAuthCredential phoneAuthCredential}) async {
    return await authDataSource.activate(
        phoneAuthCredential: phoneAuthCredential);
  }
}
