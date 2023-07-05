import 'dart:async';
import 'package:servicio_asistencia/models/matricula/MatriculaModelo.dart';
import 'package:servicio_asistencia/repositories/MatriculaRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'matricula_event.dart';
part 'matricula_state.dart';

class MatriculaBloc extends Bloc<MatriculaEvent, MatriculaState> {
  late final MatriculaRepository _matriculaRepository;

  MatriculaBloc(this._matriculaRepository) : super(MatriculaInitialState()) {
    on<MatriculaEvent>((event, emit) async {
      if (event is ListarMatriculaEvent) {
        emit(MatriculaLoadingState());
        try {
          List<MatriculaModelo> matriculaList = await _matriculaRepository.getMatricula();
          emit(MatriculaLoadedState(matriculaList));
        } catch (e) {
          emit(MatriculaError(e as Error));
        }
      } else if (event is CreateMatriculaEvent) {
        try {
          await _matriculaRepository.createMatricula(event.matricula);
          emit(MatriculaLoadingState());
          List<MatriculaModelo> matriculaList = await _matriculaRepository.getMatricula();
          emit(MatriculaLoadedState(matriculaList));
        } catch (e) {
          emit(MatriculaError(e as Error));
        }
      } else if (event is UpdateMatriculaEvent) {
        try {
          await _matriculaRepository.updateMatricula(event.matricula.id, event.matricula);
          emit(MatriculaLoadingState());
          List<MatriculaModelo> matriculaList = await _matriculaRepository.getMatricula();
          emit(MatriculaLoadedState(matriculaList));
        } catch (e) {
          emit(MatriculaError(e as Error));
        }
      } else if (event is DeleteMatriculaEvent) {
        try {
          await _matriculaRepository.deleteMatricula(event.matricula.id);
          emit(MatriculaLoadingState());
          List<MatriculaModelo> matriculaList = await _matriculaRepository.getMatricula();
          emit(MatriculaLoadedState(matriculaList));
        } catch (e) {
          emit(MatriculaError(e as Error));
        }
      }
    });
  }
}
