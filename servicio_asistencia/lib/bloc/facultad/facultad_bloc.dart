import 'dart:async';
import 'package:servicio_asistencia/models/facultad/FacultadModelo.dart';
import 'package:servicio_asistencia/repositories/FacultadRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'facultad_event.dart';
part 'facultad_state.dart';

class FacultadBloc extends Bloc<FacultadEvent, FacultadState> {
  late final FacultadRepository _facultadRepository;

  FacultadBloc(this._facultadRepository) : super(FacultadInitialState()) {
    on<FacultadEvent>((event, emit) async {
      if (event is ListarFacultadEvent) {
        emit(FacultadLoadingState());
        try {
          List<FacultadModelo> facultadList = await _facultadRepository.getFacultad();
          emit(FacultadLoadedState(facultadList));
        } catch (e) {
          emit(FacultadError(e as Error));
        }
      } else if (event is CreateFacultadEvent) {
        try {
          await _facultadRepository.createFacultad(event.facultad);
          emit(FacultadLoadingState());
          List<FacultadModelo> facultadList = await _facultadRepository.getFacultad();
          emit(FacultadLoadedState(facultadList));
        } catch (e) {
          emit(FacultadError(e as Error));
        }
      } else if (event is UpdateFacultadEvent) {
        try {
          await _facultadRepository.updateFacultad(event.facultad.id, event.facultad);
          emit(FacultadLoadingState());
          List<FacultadModelo> facultadList = await _facultadRepository.getFacultad();
          emit(FacultadLoadedState(facultadList));
        } catch (e) {
          emit(FacultadError(e as Error));
        }
      } else if (event is DeleteFacultadEvent) {
        try {
          await _facultadRepository.deleteFacultad(event.facultad.id);
          emit(FacultadLoadingState());
          List<FacultadModelo> facultadList = await _facultadRepository.getFacultad();
          emit(FacultadLoadedState(facultadList));
        } catch (e) {
          emit(FacultadError(e as Error));
        }
      }
    });
  }
}
