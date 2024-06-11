import 'package:flutter/material.dart';

import '../checkbox_list.dart';

class ChecksFormField extends FormField<List<bool>> {
  ChecksFormField({
    required List<String> titles,
    super.key,
    super.onSaved,
    super.validator,
    List<bool>? initialValues,
  }) : super(
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
                        padding: const EdgeInsets.fromLTRB(23, 10, 0, 10),
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
