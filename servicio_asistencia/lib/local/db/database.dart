// required package imports
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:servicio_asistencia/local/dao/ActividadDao.dart';
import 'package:servicio_asistencia/models/actividad/ActividadModelo.dart';
import 'package:servicio_asistencia/local/dao/AsisteciapaDao.dart';
import 'package:servicio_asistencia/models/asisteciapa/AsisteciapaModelo.dart';
import 'package:servicio_asistencia/local/dao/AsistenciaDao.dart';
import 'package:servicio_asistencia/models/asistencia/AsistenciaModelo.dart';
import 'package:servicio_asistencia/local/dao/EscuelaDao.dart';
import 'package:servicio_asistencia/models/escuela/EscuelaModelo.dart';
import 'package:servicio_asistencia/local/dao/EventoDao.dart';
import 'package:servicio_asistencia/models/evento/EventoModelo.dart';
import 'package:servicio_asistencia/local/dao/FacultadDao.dart';
import 'package:servicio_asistencia/models/facultad/FacultadModelo.dart';
import 'package:servicio_asistencia/local/dao/MatriculaDao.dart';
import 'package:servicio_asistencia/models/matricula/MatriculaModelo.dart';
import 'package:servicio_asistencia/local/dao/PeriodoDao.dart';
import 'package:servicio_asistencia/models/periodo/PeriodoModelo.dart';
import 'package:servicio_asistencia/local/dao/PersonaDao.dart';
import 'package:servicio_asistencia/models/persona/PersonaModelo.dart';
import 'package:floor/floor.dart';

part 'database.g.dart';

@Database(version: 1, entities: [ActividadModelo,AsisteciapaModelo,AsistenciaModelo,
EscuelaModelo,EventoModelo,FacultadModelo,MatriculaModelo,PeriodoModelo,PersonaModelo])
abstract class AppDatabase extends FloorDatabase{
  ActividadDao get actividadDao;
  AsisteciapaDao get asisteciapaDao;
  AsistenciaDao get asistenciaDao;
  EscuelaDao get escuelaDao;
  EventoDao get eventoDao;
  FacultadDao get facultadDao;
  MatriculaDao get matriculaDao;
  PeriodoDao get periodoDao;
  PersonaDao get personaDao;
}