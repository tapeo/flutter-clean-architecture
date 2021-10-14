import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/data/datasources/auth_datasource.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/usecases/auth_listener.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/usecases/auth_usecase.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/usecases/code_activation_usecase.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/presentation/providers/auth_provider.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// Data sources
  getIt.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(authInstance: firebaseAuth));

  /// Repositories
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDataSource: getIt()));

  /// Use cases
  getIt.registerLazySingleton<AuthUseCase>(
      () => AuthUseCase(authRepository: getIt()));
  getIt.registerLazySingleton<CodeActivationUseCase>(
      () => CodeActivationUseCase(authRepository: getIt()));
  getIt.registerLazySingleton<AuthListenerUseCase>(
      () => AuthListenerUseCase(authRepository: getIt()));
  getIt.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(authRepository: getIt()));

  /// Providers
  getIt.registerLazySingleton<AuthProvider>(() => AuthProvider(
        authUseCase: getIt(),
        activationUseCase: getIt(),
        authListenerUseCase: getIt(),
        logoutUseCase: getIt(),
      ));
}
