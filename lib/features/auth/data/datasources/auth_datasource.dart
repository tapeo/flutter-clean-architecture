import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  Future<void> authPhone(
    String phone, {
    required Function(PhoneAuthCredential) success,
    required Function(FirebaseAuthException) error,
    required Function(String verificationId) codeSent,
  });

  Future<User> activate({required PhoneAuthCredential phoneAuthCredential});
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth authInstance;

  const AuthDataSourceImpl({required this.authInstance});

  @override
  Future<void> authPhone(
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
}
