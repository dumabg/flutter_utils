import 'package:flutter/material.dart';
import 'package:flutter_utils/extensions/time_of_day_to_string.dart';

class TimeOfDayFormField extends FormField<TimeOfDay> {
  final void Function(TimeOfDay)? onChanged;

  TimeOfDayFormField({
    super.key,
    required TimeOfDay super.initialValue,
    this.onChanged,
    super.onSaved,
    super.validator,
  }) : super(
          builder: (FormFieldState<TimeOfDay> state) {
            return InkWell(
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: state.context,
                  initialTime: state.value!,
                );
                if (picked != null) {
                  state.didChange(picked);
                  onChanged?.call(picked);
                }
              },
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.5, color: Colors.grey.shade400),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            state.value!.toDurationString(),
                            style: const TextStyle(fontSize: 17),
                          ),
                        ),
                      )
                    ],
                  ),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        state.errorText!,
                        style: TextStyle(
                            color: Theme.of(state.context).colorScheme.error,
                            fontSize: 12),
                      ),
                    ),
                ],
              ),
            );
          },
        );
}
