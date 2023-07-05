part of 'periodo_bloc.dart';

@immutable
abstract class PeriodoEvent {}

class ListarPeriodoEvent extends PeriodoEvent {
  ListarPeriodoEvent();
}

class DeletePeriodoEvent extends PeriodoEvent {
  PeriodoModelo periodo;
  DeletePeriodoEvent(this.periodo);
}

class UpdatePeriodoEvent extends PeriodoEvent {
  PeriodoModelo periodo;
  UpdatePeriodoEvent(this.periodo);
}

class CreatePeriodoEvent extends PeriodoEvent {
  PeriodoModelo periodo;
  CreatePeriodoEvent(this.periodo);
}
