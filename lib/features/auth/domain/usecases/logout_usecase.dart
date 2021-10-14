import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  AuthRepository authRepository;

  LogoutUseCase({required this.authRepository});

  void call() async {
    authRepository.logout();
  }
}
