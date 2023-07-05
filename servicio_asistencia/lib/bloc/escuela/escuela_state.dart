part of 'escuela_bloc.dart';

@immutable
abstract class EscuelaState {}

class EscuelaInitialState extends EscuelaState {}
class EscuelaLoadingState extends EscuelaState {}
class EscuelaLoadedState extends EscuelaState {
  List<EscuelaModelo> escuelaList;
  EscuelaLoadedState(this.escuelaList);
}
class EscuelaError extends EscuelaState {
  Error e;
  EscuelaError(this.e);
}
