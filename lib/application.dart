import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/core/style/theme.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/presentation/pages/auth_page.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/home/presentation/pages/home_page.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/locator.dart';
import 'package:provider/provider.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => getIt<AuthProvider>())
      ],
      child: MaterialApp(
        title: 'Flutter Clean Architecture',
        theme: lightTheme,
        home: Consumer<AuthProvider>(
          builder:
              (BuildContext context, AuthProvider provider, Widget? child) {
            print("--- auth state logged 2: ${provider.logged}");

            /// Reset navigator route if auth state change
            if (provider.lastLoggedState == null ||
                provider.lastLoggedState != provider.logged) {
              provider.lastLoggedState = provider.logged;

              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              });
            }

            if (provider.logged == null) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (provider.logged!) {
              return HomePage();
            } else {
              return AuthPage();
            }
          },
        ),
      ),
    );
  }
}
