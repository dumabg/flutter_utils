import 'package:flutter/widgets.dart';

class ValueNotifierNotify<T> extends ValueNotifier<T> {
  ValueNotifierNotify(T value) : super(value);

  void notify() {
    super.notifyListeners();
  }
}
