import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/usecases/auth_listener.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/usecases/auth_usecase.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/usecases/code_activation_usecase.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/usecases/logout_usecase.dart';

class AuthProvider extends ChangeNotifier {
  AuthUseCase authUseCase;
  CodeActivationUseCase activationUseCase;
  AuthListenerUseCase authListenerUseCase;
  LogoutUseCase logoutUseCase;

  bool loading = false;
  bool showCode = false;

  PhoneAuthCredential? _phoneAuthCredential;
  String? _verificationId;
  bool? lastLoggedState;
  bool? logged;

  AuthProvider({
    required this.authUseCase,
    required this.activationUseCase,
    required this.authListenerUseCase,
    required this.logoutUseCase,
  }) {
    authListenerUseCase.call(authStateChanges: (UserModel? user) {
      logged = user != null;
      print("--- auth state logged 1: ${user?.phone}");
      notifyListeners();
    });
  }

  Future<void> login({required String prefix, required String phone}) async {
    loading = true;
    notifyListeners();

    authUseCase.call(
      "$prefix$phone",
      codeSent: (String verificationId) {
        loading = true;
        showCode = true;
        _verificationId = verificationId;
        notifyListeners();
      },
      error: (FirebaseAuthException error) {
        loading = true;
        showCode = false;
        notifyListeners();
      },
      success: (PhoneAuthCredential credential) {
        // TODO Handle auto login

        // loading = true;
        // _phoneAuthCredential = credential;
        // notifyListeners();
      },
    );
  }

  Future<void> confirmCode({required String code}) async {
    PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: code);

    loading = true;
    notifyListeners();

    User user =
        await activationUseCase.call(phoneAuthCredential: authCredential);

    print(user.uid);

    loading = false;
    notifyListeners();
  }

  void logout() {
    logoutUseCase.call();
  }
}
