import 'package:form_field_validator/form_field_validator.dart';

class ChecksValidator extends FieldValidator<List<bool>?> {
  ChecksValidator({required String errorText}) : super(errorText);

  @override
  bool isValid(List<bool>? value) {
    if (value == null) {
      return false;
    }
    for (final bool checked in value) {
      if (checked) {
        return true;
      }
    }
    return false;
  }
}
