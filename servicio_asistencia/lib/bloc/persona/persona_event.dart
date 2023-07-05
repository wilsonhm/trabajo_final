part of 'persona_bloc.dart';

@immutable
abstract class PersonaEvent {}

class ListarPersonaEvent extends PersonaEvent {
  ListarPersonaEvent();
}

class DeletePersonaEvent extends PersonaEvent {
  PersonaModelo persona;
  DeletePersonaEvent(this.persona);
}

class UpdatePersonaEvent extends PersonaEvent {
  PersonaModelo persona;
  UpdatePersonaEvent(this.persona);
}

class CreatePersonaEvent extends PersonaEvent {
  PersonaModelo persona;
  CreatePersonaEvent(this.persona);
}
