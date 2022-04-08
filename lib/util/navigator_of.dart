import 'package:flutter/material.dart';

class NavigatorOf {
  static var navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState of() =>
      Navigator.of(navigatorKey.currentState!.context);
}
