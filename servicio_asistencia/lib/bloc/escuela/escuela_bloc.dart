import 'dart:async';
import 'package:servicio_asistencia/models/escuela/EscuelaModelo.dart';
import 'package:servicio_asistencia/repositories/EscuelaRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'escuela_event.dart';
part 'escuela_state.dart';

class EscuelaBloc extends Bloc<EscuelaEvent, EscuelaState> {
  late final EscuelaRepository _escuelaRepository;

  EscuelaBloc(this._escuelaRepository) : super(EscuelaInitialState()) {
    on<EscuelaEvent>((event, emit) async {
      if (event is ListarEscuelaEvent) {
        emit(EscuelaLoadingState());
        try {
          List<EscuelaModelo> escuelaList =
              await _escuelaRepository.getEscuela();
          emit(EscuelaLoadedState(escuelaList));
        } catch (e) {
          emit(EscuelaError(e as Error));
        }
      } else if (event is CreateEscuelaEvent) {
        try {
          await _escuelaRepository.createEscuela(event.escuela);
          emit(EscuelaLoadingState());
          List<EscuelaModelo> escuelaList =
              await _escuelaRepository.getEscuela();
          emit(EscuelaLoadedState(escuelaList));
        } catch (e) {
          emit(EscuelaError(e as Error));
        }
      } else if (event is UpdateEscuelaEvent) {
        try {
          await _escuelaRepository.updateEscuela(
              event.escuela.id, event.escuela);
          emit(EscuelaLoadingState());
          List<EscuelaModelo> escuelaList =
              await _escuelaRepository.getEscuela();
          emit(EscuelaLoadedState(escuelaList));
        } catch (e) {
          emit(EscuelaError(e as Error));
        }
      } else if (event is DeleteEscuelaEvent) {
        try {
          await _escuelaRepository.deleteEscuela(event.escuela.id);
          emit(EscuelaLoadingState());
          List<EscuelaModelo> escuelaList =
              await _escuelaRepository.getEscuela();
          emit(EscuelaLoadedState(escuelaList));
        } catch (e) {
          emit(EscuelaError(e as Error));
        }
      }
    });
  }
}
