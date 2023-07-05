part of 'escuela_bloc.dart';

@immutable
abstract class EscuelaEvent {}

class ListarEscuelaEvent extends EscuelaEvent {
  ListarEscuelaEvent();
}

class DeleteEscuelaEvent extends EscuelaEvent {
  EscuelaModelo escuela;
  DeleteEscuelaEvent(this.escuela);
}

class UpdateEscuelaEvent extends EscuelaEvent {
  EscuelaModelo escuela;
  UpdateEscuelaEvent(this.escuela);
}

class CreateEscuelaEvent extends EscuelaEvent {
  EscuelaModelo escuela;
  CreateEscuelaEvent(this.escuela);
}
