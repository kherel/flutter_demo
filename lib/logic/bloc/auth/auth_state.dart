import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthState extends Equatable {
  AuthState([List props = const []]) : super(props);
}

class Authenticated extends AuthState {
  Authenticated() : super();

  @override
  String toString() => 'Auth is authenticated';
}

class Unauthenticated extends AuthState {
  Unauthenticated({this.error})
      : hasError = error != null,
        super([error]);

  final Exception error;
  final bool hasError;

  @override
  String toString() {
    return 'Auth is unauthenticated${hasError ? 'error: $error' : null}';
  }
}

class Loading extends AuthState {
  @override
  String toString() => 'Auth loading';
}
