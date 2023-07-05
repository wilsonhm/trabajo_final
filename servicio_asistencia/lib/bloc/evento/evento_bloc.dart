import 'dart:async';
import 'package:servicio_asistencia/models/evento/EventoModelo.dart';
import 'package:servicio_asistencia/repositories/EventoRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'evento_event.dart';
part 'evento_state.dart';

class EventoBloc extends Bloc<EventoEvent, EventoState> {
  late final EventoRepository _eventoRepository;

  EventoBloc(this._eventoRepository) : super(EventoInitialState()) {
    on<EventoEvent>((event, emit) async {
      if (event is ListarEventoEvent) {
        emit(EventoLoadingState());
        try {
          List<EventoModelo> eventoList = await _eventoRepository.getEvento();
          emit(EventoLoadedState(eventoList));
        } catch (e) {
          emit(EventoError(e as Error));
        }
      } else if (event is CreateEventoEvent) {
        try {
          await _eventoRepository.createEvento(event.evento);
          emit(EventoLoadingState());
          List<EventoModelo> eventoList = await _eventoRepository.getEvento();
          emit(EventoLoadedState(eventoList));
        } catch (e) {
          emit(EventoError(e as Error));
        }
      } else if (event is UpdateEventoEvent) {
        try {
          await _eventoRepository.updateEvento(event.evento.id, event.evento);
          emit(EventoLoadingState());
          List<EventoModelo> eventoList = await _eventoRepository.getEvento();
          emit(EventoLoadedState(eventoList));
        } catch (e) {
          emit(EventoError(e as Error));
        }
      } else if (event is DeleteEventoEvent) {
        try {
          await _eventoRepository.deleteEvento(event.evento.id);
          emit(EventoLoadingState());
          List<EventoModelo> eventoList = await _eventoRepository.getEvento();
          emit(EventoLoadedState(eventoList));
        } catch (e) {
          emit(EventoError(e as Error));
        }
      }
    });
  }
}
