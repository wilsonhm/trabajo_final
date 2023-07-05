part of 'persona_bloc.dart';

@immutable
abstract class PersonaState {}

class PersonaInitialState extends PersonaState {}
class PersonaLoadingState extends PersonaState {}
class PersonaLoadedState extends PersonaState {
  List<PersonaModelo> personaList;
  PersonaLoadedState(this.personaList);
}

class PersonaError extends PersonaState {
  Error er;
  PersonaError(this.er);
}
