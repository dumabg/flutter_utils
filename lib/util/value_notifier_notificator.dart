import 'package:flutter/widgets.dart';

class ValueNotifierNotificator<T> extends ValueNotifier<T> {
  ValueNotifierNotificator(T value) : super(value);

  void notify() {
    super.notifyListeners();
  }
}
