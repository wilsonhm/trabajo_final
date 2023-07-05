
import 'package:servicio_asistencia/models/asistencia/AsistenciaModelo.dart';
import 'package:servicio_asistencia/repositories/AsistenciaRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'asistencia_event.dart';
part 'asistencia_state.dart';

class AsistenciaBloc extends Bloc<AsistenciaEvent, AsistenciaState> {
  late final AsistenciaRepository _asistenciaRepository;

  AsistenciaBloc(this._asistenciaRepository) : super(AsistenciaInitialState()) {
    on<AsistenciaEvent>((event, emit) async {
      if (event is ListarAsistenciaEvent) {
        emit(AsistenciaLoadingState());
        try {
          List<AsistenciaModelo> asistenciaList =
              await _asistenciaRepository.getAsistencia();
          emit(AsistenciaLoadedState(asistenciaList));
        } catch (e) {
          emit(AsistenciaError(e as Error));
        }
      } else if (event is CreateAsistenciaEvent) {
        try {
          await _asistenciaRepository.createAsistencia(event.asistencia);
          emit(AsistenciaLoadingState());
          List<AsistenciaModelo> asistenciaList =
              await _asistenciaRepository.getAsistencia();
          emit(AsistenciaLoadedState(asistenciaList));
        } catch (e) {
          emit(AsistenciaError(e as Error));
        }
      } else if (event is UpdateAsistenciaEvent) {
        try {
          await _asistenciaRepository.updateAsistencia(
              event.asistencia.id, event.asistencia);
          emit(AsistenciaLoadingState());
          List<AsistenciaModelo> asistenciaList =
              await _asistenciaRepository.getAsistencia();
          emit(AsistenciaLoadedState(asistenciaList));
        } catch (e) {
          emit(AsistenciaError(e as Error));
        }
      } else if (event is DeleteAsistenciaEvent) {
        try {
          await _asistenciaRepository.deleteAsistencia(event.asistencia.id);
          emit(AsistenciaLoadingState());
          List<AsistenciaModelo> asistenciaList =
              await _asistenciaRepository.getAsistencia();
          emit(AsistenciaLoadedState(asistenciaList));
        } catch (e) {
          emit(AsistenciaError(e as Error));
        }
      }
    });
  }
}
