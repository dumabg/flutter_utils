import 'package:flutter/widgets.dart';

void showWidget(GlobalKey key, {Duration duration = Duration.zero}) {
  key.currentContext?.findRenderObject()?.showOnScreen(duration: duration);
}
