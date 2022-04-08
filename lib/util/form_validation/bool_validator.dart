import 'package:form_field_validator/form_field_validator.dart';

class BoolValidator extends FieldValidator<bool?> {
  final bool state;
  BoolValidator({this.state = true, required String errorText})
      : super(errorText);

  @override
  bool isValid(bool? value) {
    if (value == null) {
      return false;
    }
    return value == state;
  }
}
