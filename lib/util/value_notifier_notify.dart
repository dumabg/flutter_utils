import 'package:flutter/widgets.dart';

class ValueNotifierNotify<T> extends ValueNotifier<T> {
  ValueNotifierNotify(super._value);

  void notify() {
    super.notifyListeners();
  }
}
