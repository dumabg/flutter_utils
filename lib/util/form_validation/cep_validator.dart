import 'package:dart_utils/extensions/string/remove_chars.dart';
import 'package:form_field_validator/form_field_validator.dart';

class CEPValidator extends TextFieldValidator {
  CEPValidator(super.errorText);

  @override
  bool isValid(String? value) {
    if (value == null) {
      return false;
    }
    // https://github.com/this-empathy/dart_validator/blob/master/lib/src/cep.dart
    final RegExp re = RegExp(r'\d{5}-\d{3}');
    final cep = value.removeWhiteSpace();
    return re.hasMatch(cep);
  }
}
