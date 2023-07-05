import 'package:servicio_asistencia/apis/evento/evento_api.dart';
import 'package:servicio_asistencia/local/db/database.dart';
import 'package:servicio_asistencia/models/evento/EventoModelo.dart';
import 'package:servicio_asistencia/util/NetworConnection.dart';
import 'package:servicio_asistencia/util/TokenUtil.dart';
import 'package:dio/dio.dart';

class EventoRepository {
  EventoApi? eventoApi;

  EventoRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    eventoApi = EventoApi(_dio);
  }

  Future<AppDatabase> connection() async {
    return await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  }

  Future<List<EventoModelo>> getEvento() async {
    final database = await connection();
    final eventoDao = database.eventoDao;
    if (await isConected()) {
      var data = await eventoApi!.getEvento(TokenUtil.TOKEN).then(
        (value) => value.data,
      );
      data.forEach(
        (el) async {
          await eventoDao.insertarEvento(
            EventoModelo(
              id: el.id,
              nom_evento: el.nom_evento,
              fecha: el.fecha,
              horai: el.horai,
              min_toler: el.min_toler,
              latitud: el.latitud,
              longitud: el.longitud,
              estado: el.estado,
              evaluar: el.evaluar,
              perfil_evento: el. perfil_evento,
              periodoId: el.periodoId,
            ),
          );
        },
      );
      return data;
    } else {
      return await eventoDao.listarEvento();
    }
  }

  Future<RespEventoModelo> deleteEvento(int id) async {
    return await eventoApi!.deleteEvento(TokenUtil.TOKEN, id);
  }

  Future<RespEventoModelo> updateEvento(
    int id,
    EventoModelo evento,
  ) async {
    return await eventoApi!.updateEvento(TokenUtil.TOKEN, id, evento);
  }

  Future<RespEventoModelo> createEvento(EventoModelo evento) async {
    return await eventoApi!.createEvento(TokenUtil.TOKEN, evento);
  }
}
