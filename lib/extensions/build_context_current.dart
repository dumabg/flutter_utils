import 'package:flutter/widgets.dart';
import 'package:flutter_utils/util/navigator_of.dart';

extension BuildContextCurrent on BuildContext {
  static BuildContext get current =>
      NavigatorOf.navigatorKey.currentState!.context;
}
