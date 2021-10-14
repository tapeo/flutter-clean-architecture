import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/application.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/config.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/locator.dart';

Future<void> mainCom({required bool development, required String env}) async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize the [Config] class based on the parameter received as file path
  await Config.initialize(development, 'assets/config/$env.json');

  await Firebase.initializeApp();

  /// Setup the injector
  setupLocator();

  if (Config.authEmulator()) {
    print("--- user auth emulator ---");
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  runApp(const Application());
}
