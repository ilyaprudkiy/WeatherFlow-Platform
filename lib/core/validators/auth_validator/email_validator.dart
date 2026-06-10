import 'package:weather_app/core/error/failure/failure.dart';

class EmailValidator {
  static ValidationFailure? emailValidate(String email, {String? context}) {
    final trimmedEmail = email.trim();
    if (trimmedEmail.isEmpty) {
      return ValidationFailure('The email field is empty',
          debugMessage: context ?? '');
    }
    final emailRegex =  RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!emailRegex.hasMatch(trimmedEmail)) {
      return ValidationFailure('not correct email',
          debugMessage: context ?? '');
    }
    return null;
  }
}
