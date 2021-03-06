import 'dart:convert';
import 'package:flutter/services.dart';

abstract class Config {
  static late Map<String, dynamic> _config;
  static late bool _development;

  /// Inizialize [Config] class
  ///
  /// Pass [development] true when launch production main (main_prod.dart) and
  /// and the config file of interest
  static Future<void> initialize(bool development, String configFile) async {
    final configString = await rootBundle.loadString(configFile);
    _config = json.decode(configString) as Map<String, dynamic>;
    _development = development;
  }

  /// The starting [endpoint] based on the environment
  static String endpoint() {
    return _config['endpoint'] as String;
  }

  /// The [development] value based on the environment
  static bool development() {
    return _development;
  }

  static String wssEndpoint() {
    return _config['wss_endpoint'] as String;
  }

  static bool authEmulator() {
    return _config['auth_emulator'] as bool;
  }
}
