import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {Key? key,
      Widget? title,
      FormFieldSetter<bool>? onSaved,
      FormFieldValidator<bool>? validator,
      EdgeInsetsGeometry contentPadding = EdgeInsets.zero,
      bool initialValue = false,
      bool autovalidate = false})
      : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                title: title,
                contentPadding: contentPadding,
                value: state.value,
                onChanged: state.didChange,
                subtitle: state.hasError
                    ? Builder(
                        builder: (BuildContext context) => Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            state.errorText!,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 12),
                          ),
                        ),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              );
            });
}
