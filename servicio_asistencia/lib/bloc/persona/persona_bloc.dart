import 'dart:async';
import 'package:servicio_asistencia/models/persona/PersonaModelo.dart';
import 'package:servicio_asistencia/repositories/PersonaRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';


part 'persona_event.dart';
part 'persona_state.dart';

class PersonaBloc extends Bloc<PersonaEvent, PersonaState> {

  late final PersonaRepository _personaRepository;

  PersonaBloc(this._personaRepository) : super(PersonaInitialState()) {
    on<PersonaEvent>((event, emit) async{
      // TODO: implement event handler
      if(event is ListarPersonaEvent){
        emit(PersonaLoadingState());
        try{
          List<PersonaModelo> personaList = await _personaRepository.getPersonas();
          emit(PersonaLoadedState(personaList));
        } catch(e){
          emit(PersonaError(e as Error));
        }
      } else if(event is CreatePersonaEvent){
        try{
          await _personaRepository.createPersona(event.persona);
          emit(PersonaLoadingState());
          List<PersonaModelo> personaList = await _personaRepository.getPersonas();
          emit(PersonaLoadedState(personaList));
        } catch(e){
          emit(PersonaError(e as Error));
        }
      } else if(event is UpdatePersonaEvent){
        try{
          await _personaRepository.updatePersona(event.persona.id, event.persona);
          emit(PersonaLoadingState());
          List<PersonaModelo> personaList = await _personaRepository.getPersonas();
          emit(PersonaLoadedState(personaList));
        } catch(e){
          emit(PersonaError(e as Error));
        }
      } else if(event is DeletePersonaEvent){
        try{
          await _personaRepository.deletePersona(event.persona.id);
          emit(PersonaLoadingState());
          List<PersonaModelo> personaList = await _personaRepository.getPersonas();
          emit(PersonaLoadedState(personaList));
        } catch(e){
          emit(PersonaError(e as Error));
        }
      }
    });
  }
}
