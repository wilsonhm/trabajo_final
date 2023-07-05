part of 'asisteciapa_bloc.dart';

@immutable
abstract class AsisteciapaEvent {}

class ListarAsisteciapaEvent extends AsisteciapaEvent {
  ListarAsisteciapaEvent();
}

class DeleteAsisteciapaEvent extends AsisteciapaEvent {
  AsisteciapaModelo asisteciapa;
  DeleteAsisteciapaEvent(this.asisteciapa);
}

class UpdateAsisteciapaEvent extends AsisteciapaEvent {
  AsisteciapaModelo asisteciapa;
  UpdateAsisteciapaEvent(this.asisteciapa);
}

class CreateAsisteciapaEvent extends AsisteciapaEvent {
  AsisteciapaModelo asisteciapa;
  CreateAsisteciapaEvent(this.asisteciapa);
}
