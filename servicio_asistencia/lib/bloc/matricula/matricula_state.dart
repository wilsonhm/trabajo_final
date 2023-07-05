part of 'matricula_bloc.dart';

@immutable
abstract class MatriculaState {}

class MatriculaInitialState extends MatriculaState {}
class MatriculaLoadingState extends MatriculaState {}
class MatriculaLoadedState extends MatriculaState {
  List<MatriculaModelo> matriculaList;
  MatriculaLoadedState(this.matriculaList);
}
class MatriculaError extends MatriculaState{
  Error e;
  MatriculaError(this.e);
}
