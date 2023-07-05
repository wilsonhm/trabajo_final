import 'package:servicio_asistencia/apis/escuela/escuela_api.dart';
import 'package:servicio_asistencia/local/db/database.dart';
import 'package:servicio_asistencia/models/escuela/EscuelaModelo.dart';
import 'package:servicio_asistencia/util/NetworConnection.dart';
import 'package:servicio_asistencia/util/TokenUtil.dart';
import 'package:dio/dio.dart';

class EscuelaRepository {
  EscuelaApi? escuelaApi;

  EscuelaRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    escuelaApi = EscuelaApi(_dio);
  }

  Future<AppDatabase> connection() async {
    return await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  }

  Future<List<EscuelaModelo>> getEscuela() async {
    final database = await connection();
    final escuelaDao = database.escuelaDao;
    if (await isConected()) {
      var data = await escuelaApi!.getEscuela(TokenUtil.TOKEN).then(
        (value) => value.data,
      );
      data.forEach(
        (el) async {
          await escuelaDao.insertarEscuela(
            EscuelaModelo(
              id: el.id,
              nombreeap: el.nombreeap,
              estado: el.estado,
              inicialesEap: el.inicialesEap,
              facultadId: el.facultadId,
            ),
          );
        },
      );
      return data;
    } else {
      return await escuelaDao.listarEscuela();
    }
  }

  Future<RespEscuelaModelo> deleteEscuela(int id) async {
    return await escuelaApi!.deleteEscuela(TokenUtil.TOKEN, id);
  }

  Future<RespEscuelaModelo> updateEscuela(
    int id,
    EscuelaModelo escuela,
  ) async {
    return await escuelaApi!.updateEscuela(TokenUtil.TOKEN, id, escuela);
  }

  Future<RespEscuelaModelo> createEscuela(EscuelaModelo escuela) async {
    return await escuelaApi!.createEscuela(TokenUtil.TOKEN, escuela);
  }
}
