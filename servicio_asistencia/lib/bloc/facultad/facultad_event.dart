part of 'facultad_bloc.dart';

@immutable
abstract class FacultadEvent {}

class ListarFacultadEvent extends FacultadEvent {
  ListarFacultadEvent();
}

class DeleteFacultadEvent extends FacultadEvent {
  FacultadModelo facultad;
  DeleteFacultadEvent(this.facultad);
}

class UpdateFacultadEvent extends FacultadEvent {
  FacultadModelo facultad;
  UpdateFacultadEvent(this.facultad);
}

class CreateFacultadEvent extends FacultadEvent {
  FacultadModelo facultad;
  CreateFacultadEvent(this.facultad);
}
