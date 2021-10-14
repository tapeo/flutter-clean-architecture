import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/data/datasources/auth_datasource.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  const AuthRepositoryImpl({required this.authDataSource});

  @override
  void phone(
    String phone, {
    required Function(PhoneAuthCredential) success,
    required Function(FirebaseAuthException) error,
    required Function(String verificationId) codeSent,
  }) {
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

  @override
  void listen({required Function(UserModel? user) authStateChanges}) {
    authDataSource.listen(authStateChanges: (User? user) {
      if (user != null) {
        UserModel userModel = UserModel(phone: user.phoneNumber);
        authStateChanges(userModel);
      } else {
        authStateChanges(null);
      }
    });
  }

  @override
  void logout() {
    authDataSource.logout();
  }
}
