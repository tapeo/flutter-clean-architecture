import 'package:flutter_clean_architecture_firebase_phone_auth/main_com.dart';

Future<void> main() async {
  await mainCom(env: "prod", development: false);
}
