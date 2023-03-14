import 'package:flutter/material.dart';

import '../checkbox_list.dart';

class ChecksFormField extends FormField<List<bool>> {
  ChecksFormField({
    Key? key,
    FormFieldSetter<List<bool>>? onSaved,
    FormFieldValidator<List<bool>>? validator,
    required List<String> titles,
    List<bool>? initialValues,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue:
                initialValues ?? List<bool>.filled(titles.length, false),
            builder: (FormFieldState<List<bool>> state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CheckboxList(
                      options: titles,
                      checked: state.value!,
                    ),
                    if (state.hasError)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(23.0, 10.0, 0, 10.0),
                        child: Text(
                          state.errorText!,
                          style: TextStyle(
                              color: Theme.of(state.context).colorScheme.error,
                              fontSize: 12),
                        ),
                      ),
                  ],
                ));
}
