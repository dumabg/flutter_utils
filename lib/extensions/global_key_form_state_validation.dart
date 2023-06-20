import 'package:flutter/widgets.dart';

extension GlobalKeyFormStateValidation on GlobalKey<FormState> {
  /// Validates a Form and returns a boolean value indicating whether the form
  /// is valid. It checks all the children FormFields to determine which is invalid.
  /// If found it, shows on the screen.
  bool validateAndShowInvalid() {
    bool allValid = currentState?.validate() ?? true;
    if (!allValid) {
      bool found = false;
      currentContext?.visitChildElements((Element element) {
        if (!found) {
          found = _visitChildren(element);
        }
      });
    }
    return allValid;
  }

  bool _visitChildren(Element element) {
    bool found = false;
    element.visitChildElements((element) {
      if (!found) {
        var widget = element.widget;
        if (widget is FormField) {
          FormFieldState<dynamic> state =
              (element as StatefulElement).state as FormFieldState;
          if (state.hasError) {
            state.context
                .findRenderObject()
                ?.showOnScreen(duration: const Duration(seconds: 1));
            found = true;
          }
        }
        if (!found) {
          found = _visitChildren(element);
        }
      }
    });
    return found;
  }
}
