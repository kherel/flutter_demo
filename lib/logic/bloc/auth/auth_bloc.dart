import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

import 'package:my_flutter_course/logic/logic.dart';
import 'package:meta/meta.dart';

final Logger log = Logger('auth block');

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({@required this.userRepository, @required this.appBloc});

  final AppBloc appBloc;
  final UserRepository userRepository;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoggingdIn:
        yield* _mapLoggendInToState(event);
        break;
      case LoggedOut:
        yield Unauthenticated();
    }
  }

  @override
  AuthState get initialState => Unauthenticated();

  Stream<AuthState> _mapLoggendInToState(LoggingdIn event) async* {
    yield Loading();
    try {
      final loggedUser = await userRepository.signInWithCredentials(
        event.email.toString(),
        event.password,
      );
      appBloc.dispatch(UpdateLoggedUser(loggedUser));
      yield Authenticated();
    } on Exception catch (e) {
      yield Unauthenticated(error: e);
    }
  }
}
