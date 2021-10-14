import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/repositories/auth_repository.dart';

class CodeActivationUseCase {
  AuthRepository authRepository;

  CodeActivationUseCase({required this.authRepository});

  Future<User> call({required PhoneAuthCredential phoneAuthCredential}) async {
    return await authRepository.activate(
        phoneAuthCredential: phoneAuthCredential);
  }
}
