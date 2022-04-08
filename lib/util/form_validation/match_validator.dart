import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/widgets.dart';

class MatchValidator extends FieldValidator<String?> {
  final TextEditingController editingController;

  MatchValidator({required this.editingController, required String errorText})
      : super(errorText);

  @override
  bool isValid(String? value) {
    return value == editingController.text;
  }
}
