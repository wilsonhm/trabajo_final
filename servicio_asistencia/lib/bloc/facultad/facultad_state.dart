part of 'facultad_bloc.dart';

@immutable
abstract class FacultadState {}

class FacultadInitialState extends FacultadState {}
class FacultadLoadingState extends FacultadState {}
class FacultadLoadedState extends FacultadState {
  List<FacultadModelo> facultadList;
  FacultadLoadedState(this.facultadList);
}
class FacultadError extends FacultadState {
  Error e;
  FacultadError(this.e);
}
