part of 'periodo_bloc.dart';

@immutable
abstract class PeriodoState {}

class PeriodoInitialState extends PeriodoState {}
class PeriodoLoadingState extends PeriodoState {}
class PeriodoLoadedState extends PeriodoState {
  List<PeriodoModelo> periodoList;
  PeriodoLoadedState(this.periodoList);
}
class PeriodoError extends PeriodoState{
  Error e;
  PeriodoError(this.e);
}
