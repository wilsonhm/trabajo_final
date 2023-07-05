part of 'matricula_bloc.dart';

@immutable
abstract class MatriculaEvent {}

class ListarMatriculaEvent extends MatriculaEvent {
  ListarMatriculaEvent();
}

class DeleteMatriculaEvent extends MatriculaEvent {
  MatriculaModelo matricula;
  DeleteMatriculaEvent(this.matricula);
}

class UpdateMatriculaEvent extends MatriculaEvent {
  MatriculaModelo matricula;
  UpdateMatriculaEvent(this.matricula);
}

class CreateMatriculaEvent extends MatriculaEvent {
  MatriculaModelo matricula;
  CreateMatriculaEvent(this.matricula);
}
