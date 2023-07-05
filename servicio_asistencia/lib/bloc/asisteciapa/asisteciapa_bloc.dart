import 'package:servicio_asistencia/models/asisteciapa/AsisteciapaModelo.dart';
import 'package:servicio_asistencia/repositories/AsisteciapaRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'asisteciapa_event.dart';
part 'asisteciapa_state.dart';

class AsisteciapaBloc extends Bloc<AsisteciapaEvent, AsisteciapaState> {
  late final AsisteciapaRepository _asisteciapaRepository;

  AsisteciapaBloc(this._asisteciapaRepository)
      : super(AsisteciapaInitialState()) {
    on<AsisteciapaEvent>((event, emit) async {
      if (event is ListarAsisteciapaEvent) {
        emit(AsisteciapaLoadingState());
        try {
          List<AsisteciapaModelo> asisteciapaList =
              await _asisteciapaRepository.getAsisteciapa();
          emit(AsisteciapaLoadedState(asisteciapaList));
        } catch (e) {
          emit(AsisteciapaError(e as Error));
        }
      } else if (event is CreateAsisteciapaEvent) {
        /*try {
          await _asisteciapaRepository.createAsisteciapa(event.asisteciapa);
          emit(AsisteciapaLoadingState());
          List<AsisteciapaModelo> asisteciapaList =
              await _asisteciapaRepository.getAsisteciapa();
          emit(AsisteciapaLoadedState(asisteciapaList));
        } catch (e) {
          emit(AsisteciapaError(e as Error));
        }
      } else if (event is UpdateAsisteciapaEvent) {
        try {
          await _asisteciapaRepository.updateAsisteciapa(
              event.asisteciapa.id, event.asisteciapa);
          emit(AsisteciapaLoadingState());
          List<AsisteciapaModelo> asisteciapaList =
              await _asisteciapaRepository.getAsisteciapa();
          emit(AsisteciapaLoadedState(asisteciapaList));
        } catch (e) {
          emit(AsisteciapaError(e as Error));
        }*/
      } else if (event is DeleteAsisteciapaEvent) {
        try {
          await _asisteciapaRepository.deleteAsisteciapa(event.asisteciapa.id);
          emit(AsisteciapaLoadingState());
          List<AsisteciapaModelo> asisteciapaList =
              await _asisteciapaRepository.getAsisteciapa();
          emit(AsisteciapaLoadedState(asisteciapaList));
        } catch (e) {
          emit(AsisteciapaError(e as Error));
        }
      }
    });
  }
}
