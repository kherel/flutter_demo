import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_flutter_course/logic/logic.dart';

@immutable
abstract class AuthEvent extends Equatable {
  AuthEvent([List<String> props = const <String>[]]) : super(props);
}

class LoggingdIn extends AuthEvent {
  LoggingdIn({
    @required this.email,
    @required this.password,
  }) : super([email.toString(), password]);

  final Email email;
  final String password;

  @override
  String toString() => 'LoggingIn { email: $email, password: $password  }';
}

class LoggedOut extends AuthEvent {
  @override
  String toString() => 'LoggedOut';
}
