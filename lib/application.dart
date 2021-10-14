import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/core/style/theme.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/presentation/pages/auth_page.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      theme: lightTheme,
      home: const AuthPage(),
    );
  }
}
