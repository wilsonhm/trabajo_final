import 'package:servicio_asistencia/apis/facultad/facultad_api.dart';
import 'package:servicio_asistencia/local/db/database.dart';
import 'package:servicio_asistencia/models/facultad/FacultadModelo.dart';
import 'package:servicio_asistencia/util/NetworConnection.dart';
import 'package:servicio_asistencia/util/TokenUtil.dart';
import 'package:dio/dio.dart';

class FacultadRepository {
  FacultadApi? facultadApi;

  FacultadRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    facultadApi = FacultadApi(_dio);
  }

  Future<AppDatabase> connection() async {
    return await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  }

  Future<List<FacultadModelo>> getFacultad() async {
    final database = await connection();
    final facultadDao = database.facultadDao;
    if (await isConected()) {
      var data = await facultadApi!.getFacultad(TokenUtil.TOKEN).then(
        (value) => value.data,
      );
      data.forEach(
        (el) async {
          await facultadDao.insertarFacultad(
            FacultadModelo(
              id: el.id,
              nombrefac: el.nombrefac,
              estado: el.estado,
              inicales: el.inicales,
            ),
          );
        },
      );
      return data;
    } else {
      return await facultadDao.listarFacultad();
    }
  }

  Future<RespFacultadModelo> deleteFacultad(int id) async {
    return await facultadApi!.deleteFacultad(TokenUtil.TOKEN, id);
  }

  Future<RespFacultadModelo> updateFacultad(
    int id,
    FacultadModelo facultad,
  ) async {
    return await facultadApi!.updateFacultad(TokenUtil.TOKEN, id, facultad);
  }

  Future<RespFacultadModelo> createFacultad(FacultadModelo facultad) async {
    return await facultadApi!.createFacultad(TokenUtil.TOKEN, facultad);
  }
}
