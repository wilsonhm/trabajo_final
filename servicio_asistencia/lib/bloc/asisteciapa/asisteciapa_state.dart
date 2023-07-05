part of 'asisteciapa_bloc.dart';

@immutable
abstract class AsisteciapaState {}

class AsisteciapaInitialState extends AsisteciapaState {}
class AsisteciapaLoadingState extends AsisteciapaState {}
class AsisteciapaLoadedState extends AsisteciapaState {
  List<AsisteciapaModelo> asisteciapaList;
  AsisteciapaLoadedState(this.asisteciapaList);
}
class AsisteciapaError extends AsisteciapaState {
  Error e;
  AsisteciapaError(this.e);
}
