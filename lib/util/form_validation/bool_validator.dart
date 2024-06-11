import 'package:form_field_validator/form_field_validator.dart';

class BoolValidator extends FieldValidator<bool?> {
  final bool state;
  BoolValidator({required String errorText, this.state = true})
      : super(errorText);

  @override
  bool isValid(bool? value) {
    if (value == null) {
      return false;
    }
    return value == state;
  }
}
