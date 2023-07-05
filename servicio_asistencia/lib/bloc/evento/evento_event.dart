part of 'evento_bloc.dart';

@immutable
abstract class EventoEvent {}

class ListarEventoEvent extends EventoEvent {
  ListarEventoEvent();
}

class DeleteEventoEvent extends EventoEvent {
  EventoModelo evento;
  DeleteEventoEvent(this.evento);
}

class UpdateEventoEvent extends EventoEvent {
  EventoModelo evento;
  UpdateEventoEvent(this.evento);
}

class CreateEventoEvent extends EventoEvent {
  EventoModelo evento;
  CreateEventoEvent(this.evento);
}
