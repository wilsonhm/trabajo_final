part of 'asistencia_bloc.dart';

@immutable
abstract class AsistenciaEvent {}

class ListarAsistenciaEvent extends AsistenciaEvent {
  ListarAsistenciaEvent();
}

class DeleteAsistenciaEvent extends AsistenciaEvent {
  AsistenciaModelo asistencia;
  DeleteAsistenciaEvent(this.asistencia);
}

class UpdateAsistenciaEvent extends AsistenciaEvent {
  AsistenciaModelo asistencia;
  UpdateAsistenciaEvent(this.asistencia);
}

class CreateAsistenciaEvent extends AsistenciaEvent {
  AsistenciaModelo asistencia;
  CreateAsistenciaEvent(this.asistencia);
}
