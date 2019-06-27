import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:my_flutter_course/logic/logic.dart';

/// Root block contains application data. Returns only ready state.
/// No external calls in reducer, only managing bloc state it self.

class AppBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => InitialAppState();

  @override
  Stream<ReadyAppState> mapEventToState(
    AppEvent event,
  ) async* {
    switch (event.runtimeType) {
      case UpdateLoggedUser:
        yield currentState.cloneWith(
          loggedUser: (event as UpdateLoggedUser).loggedUser,
        );
        break;
    }
  }
}

@immutable
abstract class AppState extends Equatable {
  AppState({this.loggedUser})
      : super(
          [loggedUser],
        );

  final Me loggedUser;

  ReadyAppState cloneWith({Me loggedUser}) {
    return ReadyAppState(loggedUser: loggedUser);
  }
}

class InitialAppState extends AppState {
  @override
  String toString() => 'Initial AppState';
}

class ReadyAppState extends AppState {
  ReadyAppState({loggedUser}) : super(loggedUser: loggedUser);

  @override
  String toString() => 'Ready AppState';
}

@immutable
abstract class AppEvent extends Equatable {
  AppEvent([List props = const []]) : super(props);
}

@immutable
class UpdateLoggedUser extends AppEvent {
  UpdateLoggedUser(this.loggedUser) : super([loggedUser]);

  final Me loggedUser;

  @override
  String toString() => 'Update loggedUser $loggedUser';
}
