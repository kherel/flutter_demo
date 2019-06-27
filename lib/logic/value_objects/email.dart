import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class Email extends Equatable {
  Email(String email)
      : name = email.split('@')[0],
        domain = email.split('@')[1],
        super(<String>[email]) {
    if (toString() != email || !isAddressValid(email)) {
      throw const InvalidEmailException('invalid address');
    }
  }

  // just first regexp from the internet
  static RegExp exp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  final String name, domain;

  @override
  String toString() {
    return '$name@$domain';
  }

  static bool isAddressValid(String email) {
    return exp.hasMatch(email);
  }

  String toJson() {
    return toString();
  }
}

@immutable
class InvalidEmailException implements Exception {
  const InvalidEmailException(this._message);

  final String _message;

  @override
  String toString() {
    return 'Exception: $_message';
  }
}
