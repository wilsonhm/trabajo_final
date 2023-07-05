part of 'evento_bloc.dart';

@immutable
abstract class EventoState {}

class EventoInitialState extends EventoState {}
class EventoLoadingState extends EventoState {}
class EventoLoadedState extends EventoState {
  List<EventoModelo> eventoList;
  EventoLoadedState(this.eventoList);
}
class EventoError extends EventoState {
  Error e;
  EventoError(this.e);
}
