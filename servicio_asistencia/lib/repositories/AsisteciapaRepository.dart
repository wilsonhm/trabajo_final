import 'package:servicio_asistencia/apis/asisteciapa/asisteciapa_api.dart';
import 'package:servicio_asistencia/local/db/database.dart';
import 'package:servicio_asistencia/models/asisteciapa/AsisteciapaModelo.dart';
import 'package:servicio_asistencia/util/NetworConnection.dart';
import 'package:servicio_asistencia/util/TokenUtil.dart';
import 'package:dio/dio.dart';

class AsisteciapaRepository {
  AsisteciapaApi? asisteciapaApi;

  AsisteciapaRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    asisteciapaApi = AsisteciapaApi(_dio);
  }

  Future<AppDatabase> connection() async {
    return await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  }

  Future<List<AsisteciapaModelo>> getAsisteciapa() async {
    final database = await connection();
    final asisteciapaDao = database.asisteciapaDao;
    if (await isConected()) {
      var data = await asisteciapaApi!.getAsisteciapa(TokenUtil.TOKEN).then(
        (value) => value.data,
      );
      data.forEach((el) async {
          await asisteciapaDao.insertarAsisteciapa(new AsisteciapaModelo(
              id: el.id,
              fecha: el.fecha,
              horaReg: el.horaReg,
              latituda: el.latituda,
              longituda: el.longituda,
              tipo: el.tipo,
              calificacion: el.calificacion,
              cui: el.cui,
              tipoCui: el.tipoCui,
              actividadId: el.actividadId,
            ),
          );
        },
      );
      return data;
    } else {
      return await asisteciapaDao.listarAsisteciapa();
    }
  }

  Future<RespAsisteciapaModelo> deleteAsisteciapa(int id) async {
    return await asisteciapaApi!.deleteAsisteciapa(TokenUtil.TOKEN, id);
  }

 /*Future<RespAsisteciapaModelo> updateAsisteciapa(int id, AsisteciapaModelo asisteciapa,) async {
    return await asisteciapaApi!.updateAsisteciapa(TokenUtil.TOKEN, id, asisteciapa );
  }

  Future<RespAsisteciapaModelo> createAsisteciapa(AsisteciapaModelo asisteciapa) async {
    return await asisteciapaApi!.createAsisteciapa(TokenUtil.TOKEN, asisteciapa);
  }*/
}
