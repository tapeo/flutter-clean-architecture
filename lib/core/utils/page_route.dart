import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Platform page route, platform based page routing
// ignore: non_constant_identifier_names
PageRoute PlatformPageRoute({
  required WidgetBuilder? builder,
  Object? arguments,
}) {
  if (Platform.isAndroid) {
    return MaterialPageRoute(
      builder: builder!,
      settings: RouteSettings(arguments: arguments),
    );
  } else {
    return CupertinoPageRoute(
      builder: builder!,
      settings: RouteSettings(arguments: arguments),
    );
  }
}
