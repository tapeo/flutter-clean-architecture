import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  void authPhone(
    String phone, {
    required Function(PhoneAuthCredential) success,
    required Function(FirebaseAuthException) error,
    required Function(String verificationId) codeSent,
  });

  Future<User> activate({required PhoneAuthCredential phoneAuthCredential});

  void listen({required Function(User?) authStateChanges});

  void logout();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth authInstance;

  const AuthDataSourceImpl({required this.authInstance});

  @override
  void authPhone(
    String phone, {
    required Function(PhoneAuthCredential) success,
    required Function(FirebaseAuthException) error,
    required Function(String verificationId) codeSent,
  }) async {
    authInstance.verifyPhoneNumber(
        codeAutoRetrievalTimeout: codeSent,
        codeSent: (String verificationId, int? forceResendingToken) {
          codeSent(verificationId);
        },
        phoneNumber: phone,
        verificationCompleted: success,
        verificationFailed: error);
  }

  @override
  Future<User> activate(
      {required PhoneAuthCredential phoneAuthCredential}) async {
    UserCredential userCredential =
        await authInstance.signInWithCredential(phoneAuthCredential);

    return userCredential.user!;
  }

  @override
  void listen({required Function(User?) authStateChanges}) {
    authInstance.authStateChanges().listen(authStateChanges);
  }

  @override
  void logout() {
    authInstance.signOut();
  }
}
