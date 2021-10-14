import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/repositories/auth_repository.dart';

class AuthListenerUseCase {
  AuthRepository authRepository;

  AuthListenerUseCase({required this.authRepository});

  void call({required Function(UserModel? user) authStateChanges}) async {
    authRepository.listen(authStateChanges: authStateChanges);
  }
}
