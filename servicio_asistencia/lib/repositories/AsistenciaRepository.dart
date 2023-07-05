import 'package:servicio_asistencia/apis/asistencia/asistencia_api.dart';
import 'package:servicio_asistencia/local/db/database.dart';
import 'package:servicio_asistencia/models/asistencia/AsistenciaModelo.dart';
import 'package:servicio_asistencia/util/NetworConnection.dart';
import 'package:servicio_asistencia/util/TokenUtil.dart';
import 'package:dio/dio.dart';

class AsistenciaRepository {
  AsistenciaApi? asistenciaApi;

  AsistenciaRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    asistenciaApi = AsistenciaApi(_dio);
  }

  Future<AppDatabase> connection() async {
    return await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  }

  Future<List<AsistenciaModelo>> getAsistencia() async {
    final database = await connection();
    final asistenciaDao = database.asistenciaDao;
    if (await isConected()) {
      var data = await asistenciaApi!.getAsistencia(TokenUtil.TOKEN).then(
        (value) => value.data,
      );
      data.forEach(
        (el) async {
          await asistenciaDao.insertarAsistencia(
            AsistenciaModelo(
              id: el.id,
              fecha: el.fecha,
              hora: el.hora,
              latituda: el.latituda,
              longituda: el.longituda,
              tipo: el.tipo,
              tipoReg: el.tipoReg,
              idMatricula: el.idMatricula,
              idEvento: el.idEvento,
              idPersona: el.idPersona,
              calificacion: el.calificacion,
            ),
          );
        },
      );
      return data;
    } else {
      return await asistenciaDao.listarAsistencia();
    }
  }

  Future<RespAsistenciaModelo> deleteAsistencia(int id) async {
    return await asistenciaApi!.deleteAsistencia(TokenUtil.TOKEN, id);
  }

  Future<RespAsistenciaModelo> updateAsistencia(
    int id,
    AsistenciaModelo asistencia,
  ) async {
    return await asistenciaApi!.updateAsistencia(TokenUtil.TOKEN, id, asistencia);
  }

  Future<RespAsistenciaModelo> createAsistencia(AsistenciaModelo asistencia) async {
    return await asistenciaApi!.createAsistencia(TokenUtil.TOKEN, asistencia);
  }
}
