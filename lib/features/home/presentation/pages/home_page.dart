import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/core/components/space.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/core/components/squared_button.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/home/presentation/providers/home_provider.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/locator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => getIt<HomeProvider>(),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

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
                        Center(child: Text("Home")),
                        Space(),
                        SquaredButton(
                            text: "Logout",
                            click: () {
                              context.read<AuthProvider>().logout();
                            }),
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
