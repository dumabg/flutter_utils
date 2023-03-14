import 'package:flutter/material.dart';

class SwitchFormField extends FormField<bool> {
  SwitchFormField(
      {Key? key,
      Widget? offTitle,
      Widget? onTitle,
      FormFieldSetter<bool>? onSaved,
      FormFieldValidator<bool>? validator,
      bool initialValue = false})
      : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      if (offTitle != null)
                        InkWell(
                            onTap: () => state.didChange(false),
                            child: offTitle),
                      Switch(value: state.value!, onChanged: state.didChange),
                      if (onTitle != null)
                        InkWell(
                            onTap: () => state.didChange(true), child: onTitle)
                    ],
                  ),
                  if (state.hasError)
                    Text(
                      state.errorText!,
                      style: TextStyle(
                          color: Theme.of(state.context).colorScheme.error,
                          fontSize: 12),
                    ),
                ],
              );
            });
}
