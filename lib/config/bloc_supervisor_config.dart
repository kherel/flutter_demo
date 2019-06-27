import 'package:logging/logging.dart';
import 'package:bloc/bloc.dart';
import 'package:ansicolor/ansicolor.dart';

void blocSupervisorConfig() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
}

class SimpleBlocDelegate extends BlocDelegate {
  Logger eventlogger = Logger('b event:');
  Logger transitionlogger = Logger('b transition:');
  
  final AnsiPen
    white = AnsiPen()..white(bold: false), 
    redText = AnsiPen()..rgb(g: 39, b: 28, r: 100),
    pen = AnsiPen()..white()..rgb(r: 1.0, g: 0.8, b: 0.2);

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    transitionlogger.severe(
      redText(error.toString()),
      white(stacktrace.toString()),
    );
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);


    eventlogger.info(pen(event.toString()));
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    transitionlogger.info(transition);
  }
}
