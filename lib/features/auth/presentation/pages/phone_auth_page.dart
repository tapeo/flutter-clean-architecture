import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/core/components/input.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/core/components/space.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/core/components/squared_button.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/locator.dart';
import 'package:provider/provider.dart';

class PhoneAuthPage extends StatelessWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (context) => locator<AuthProvider>(),
      child: _PhoneAuthPage(),
    );
  }
}

class _PhoneAuthPage extends StatelessWidget {
  _PhoneAuthPage({Key? key}) : super(key: key);

  final TextEditingController prefixController =
      TextEditingController(text: "+39");
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController activationCodeController =
      TextEditingController();

  final FocusNode focusNode = FocusNode()..requestFocus();

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
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: _buildInput(context),
                          ),
                        ),
                        SquaredButton(
                          text: "Login",
                          click: () {
                            bool showCode =
                                context.read<AuthProvider>().showCode;

                            if (showCode) {
                              context.read<AuthProvider>().confirmCode(
                                    code: activationCodeController.text,
                                  );
                            } else {
                              context.read<AuthProvider>().login(
                                    prefix: prefixController.text,
                                    phone: phoneController.text,
                                  );
                            }
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

  _buildInput(BuildContext context) {
    bool showCode = context.watch<AuthProvider>().showCode;

    if (showCode) {
      return _activationCode();
    } else {
      return _phone();
    }
  }

  Column _phone() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox(
                width: 50,
                child: Input(
                  label: "Prefix",
                  controller: prefixController,
                  textInputType: TextInputType.numberWithOptions(signed: true),
                )),
            Space(),
            Expanded(
                child: Input(
              label: "Phone number",
              controller: phoneController,
              focus: focusNode,
              textInputType: TextInputType.number,
            )),
          ],
        ),
      ],
    );
  }

  Column _activationCode() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
                child: Input(
              label: "SMS Activation Code",
              controller: activationCodeController,
              focus: focusNode,
              textInputType: TextInputType.number,
            )),
          ],
        ),
      ],
    );
  }
}
