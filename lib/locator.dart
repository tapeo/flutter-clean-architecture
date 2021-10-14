import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/data/datasources/auth_datasource.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/usecases/auth_usecase.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/domain/usecases/code_activation_usecase.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/presentation/providers/auth_provider.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// Data sources
  locator.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(authInstance: firebaseAuth));

  /// Repositories
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDataSource: locator()));

  /// Use cases
  locator.registerLazySingleton<AuthUseCase>(
      () => AuthUseCase(authRepository: locator()));
  locator.registerLazySingleton<CodeActivationUseCase>(
      () => CodeActivationUseCase(authRepository: locator()));

  /// Providers
  locator.registerLazySingleton<AuthProvider>(
      () => AuthProvider(authUseCase: locator(), activationUseCase: locator()));
}
