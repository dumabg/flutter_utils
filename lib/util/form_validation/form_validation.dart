import 'package:flutter/widgets.dart';

extension FormValidation on GlobalKey<FormState> {
  bool validateAndShowInvalid() {
    bool allValid = currentState?.validate() ?? true;
    bool found = false;
    currentContext?.visitChildElements((Element element) {
      if (!found) {
        found = _visitChildren(element);
      }
    });
    return allValid;
  }

  bool _visitChildren(Element element) {
    bool found = false;
    element.visitChildElements((element) {
      if (!found) {
        var widget = element.widget;
        if (widget is FormField) {
          FormFieldState state =
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
