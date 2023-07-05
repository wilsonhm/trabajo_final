import 'package:servicio_asistencia/apis/periodo/periodo_api.dart';
import 'package:servicio_asistencia/local/db/database.dart';
import 'package:servicio_asistencia/models/periodo/PeriodoModelo.dart';
import 'package:servicio_asistencia/util/NetworConnection.dart';
import 'package:servicio_asistencia/util/TokenUtil.dart';
import 'package:dio/dio.dart';

class PeriodoRepository {
  PeriodoApi? periodoApi;

  PeriodoRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    periodoApi = PeriodoApi(_dio);
  }

  Future<AppDatabase> connection() async {
    return await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  }

  Future<List<PeriodoModelo>> getPeriodo() async {
    final database = await connection();
    final periodoDao = database.periodoDao;
    if (await isConected()) {
      var data = await periodoApi!.getPeriodo(TokenUtil.TOKEN).then(
        (value) => value.data,
      );
      data.forEach(
        (el) async {
          await periodoDao.insertarPeriodo(
            PeriodoModelo(
              id: el.id,
              nombre: el.nombre,
              estado: el.estado,
            ),
          );
        },
      );
      return data;
    } else {
      return await periodoDao.listarPeriodo();
    }
  }

  Future<RespPeriodoModelo> deletePeriodo(int id) async {
    return await periodoApi!.deletePeriodo(TokenUtil.TOKEN, id);
  }

  Future<RespPeriodoModelo> updatePeriodo(
    int id,
    PeriodoModelo periodo,
  ) async {
    return await periodoApi!.updatePeriodo(TokenUtil.TOKEN, id, periodo);
  }

  Future<RespPeriodoModelo> createPeriodo(PeriodoModelo periodo) async {
    return await periodoApi!.createPeriodo(TokenUtil.TOKEN, periodo);
  }
}
