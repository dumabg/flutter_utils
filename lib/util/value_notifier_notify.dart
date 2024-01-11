import 'package:flutter/widgets.dart';

class ValueNotifierNotify<T> extends ValueNotifier<T> {
  ValueNotifierNotify(super.value);

  void notify() {
    super.notifyListeners();
  }
}
