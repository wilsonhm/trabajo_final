import 'dart:async';
import 'package:servicio_asistencia/models/periodo/PeriodoModelo.dart';
import 'package:servicio_asistencia/repositories/PeriodoRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'periodo_event.dart';
part 'periodo_state.dart';

class PeriodoBloc extends Bloc<PeriodoEvent, PeriodoState> {
  late final PeriodoRepository _periodoRepository;

  PeriodoBloc(this._periodoRepository) : super(PeriodoInitialState()) {
    on<PeriodoEvent>((event, emit) async {
      if (event is ListarPeriodoEvent) {
        emit(PeriodoLoadingState());
        try {
          List<PeriodoModelo> periodoList = await _periodoRepository.getPeriodo();
          emit(PeriodoLoadedState(periodoList));
        } catch (e) {
          emit(PeriodoError(e as Error));
        }
      } else if (event is CreatePeriodoEvent) {
        try {
          await _periodoRepository.createPeriodo(event.periodo);
          emit(PeriodoLoadingState());
          List<PeriodoModelo> periodoList = await _periodoRepository.getPeriodo();
          emit(PeriodoLoadedState(periodoList));
        } catch (e) {
          emit(PeriodoError(e as Error));
        }
      } else if (event is UpdatePeriodoEvent) {
        try {
          await _periodoRepository.updatePeriodo(event.periodo.id, event.periodo);
          emit(PeriodoLoadingState());
          List<PeriodoModelo> periodoList = await _periodoRepository.getPeriodo();
          emit(PeriodoLoadedState(periodoList));
        } catch (e) {
          emit(PeriodoError(e as Error));
        }
      } else if (event is DeletePeriodoEvent) {
        try {
          await _periodoRepository.deletePeriodo(event.periodo.id);
          emit(PeriodoLoadingState());
          List<PeriodoModelo> periodoList = await _periodoRepository.getPeriodo();
          emit(PeriodoLoadedState(periodoList));
        } catch (e) {
          emit(PeriodoError(e as Error));
        }
      }
    });
  }
}
