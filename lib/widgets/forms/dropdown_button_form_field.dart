import 'package:flutter/material.dart';
import 'package:dart_utils/extensions/list_map_with_index.dart';

class DropdownButtonFormField extends FormField<int> {
  DropdownButtonFormField(
      {Key? key,
      FormFieldSetter<int>? onSaved,
      FormFieldValidator<int>? validator,
      int? index,
      Widget? icon,
      required List<String> values})
      : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: index,
          builder: (FormFieldState<int> state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<int>(
                value: state.value,
                icon: icon,
                items: values
                    .mapWithIndex<DropdownMenuItem<int>>(
                        (String value, int i) =>
                            DropdownMenuItem<int>(value: i, child: Text(value)))
                    .toList(),
                onChanged: (int? value) => state.didChange(value),
              ),
              if (state.hasError)
                Text(
                  state.errorText!,
                  style: TextStyle(
                      color: Theme.of(state.context).errorColor, fontSize: 12),
                ),
            ],
          ),
        );
}
