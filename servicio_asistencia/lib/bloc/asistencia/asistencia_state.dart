part of 'asistencia_bloc.dart';

@immutable
abstract class AsistenciaState {}

class AsistenciaInitialState extends AsistenciaState {}
class AsistenciaLoadingState extends AsistenciaState {}
class AsistenciaLoadedState extends AsistenciaState {
  List<AsistenciaModelo> asistenciaList;
  AsistenciaLoadedState(this.asistenciaList);
}
class AsistenciaError extends AsistenciaState {
  Error e;
  AsistenciaError(this.e);
}
