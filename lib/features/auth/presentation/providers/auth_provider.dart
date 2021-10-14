import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/usecases/auth_usecase.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/usecases/code_activation_usecase.dart';

class AuthProvider extends ChangeNotifier {
  AuthUseCase authUseCase;
  CodeActivationUseCase activationUseCase;

  bool loading = false;
  bool showCode = false;

  PhoneAuthCredential? _phoneAuthCredential;
  String? _verificationId;

  AuthProvider({
    required this.authUseCase,
    required this.activationUseCase,
  });

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
}
