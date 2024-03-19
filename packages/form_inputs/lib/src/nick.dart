import 'package:formz/formz.dart';

/// Validation errors for the [Nick] [FormzInput].
enum NickValidationError {
  /// Generic invalid error.
  invalid,

  /// Nick length is less than 3.
  tooShort,

  /// Nick length is greater than 20.
  tooLong,

  /// Nick contains invalid characters.
  invalidCharacters,
}

class Nick extends FormzInput<String, NickValidationError> {
  /// {@macro passwordOnLogin}
  const Nick.pure() : super.pure('');

  /// {@macro passwordOnLogin}
  const Nick.dirty([String value = '']) : super.dirty(value);

  @override
  NickValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return NickValidationError.invalid;
    }
    if (value.length < 3) {
      return NickValidationError.tooShort;
    }
    if (value.length > 20) {
      return NickValidationError.tooLong;
    }
    if (!RegExp(r'^[a-zA-Z0-9 _]+$').hasMatch(value)) {
      return NickValidationError.invalidCharacters;
    }
    return null;
  }
}
