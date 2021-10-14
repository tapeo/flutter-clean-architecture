import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/core/components/space.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/core/components/squared_button.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/core/utils/page_route.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/presentation/pages/phone_auth_page.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/locator.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (context) => locator<AuthProvider>(),
      child: const _AuthPage(),
    );
  }
}

class _AuthPage extends StatelessWidget {
  const _AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Column(
              children: [
                Space(),
                FlutterLogo(size: 150),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SquaredButton(
                          text: "Proceed",
                          click: () {
                            Navigator.push(
                                context,
                                PlatformPageRoute(
                                  builder: (context) => PhoneAuthPage(),
                                ));
                          },
                        ),
                        Space(24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
