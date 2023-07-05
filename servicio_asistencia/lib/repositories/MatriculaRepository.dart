import 'package:servicio_asistencia/apis/matricula/matricula_api.dart';
import 'package:servicio_asistencia/local/db/database.dart';
import 'package:servicio_asistencia/models/matricula/MatriculaModelo.dart';
import 'package:servicio_asistencia/util/NetworConnection.dart';
import 'package:servicio_asistencia/util/TokenUtil.dart';
import 'package:dio/dio.dart';

class MatriculaRepository {
  MatriculaApi? matriculaApi;

  MatriculaRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    matriculaApi = MatriculaApi(_dio);
  }

  Future<AppDatabase> connection() async {
    return await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  }

  Future<List<MatriculaModelo>> getMatricula() async {
    final database = await connection();
    final matriculaDao = database.matriculaDao;
    if (await isConected()) {
      var data = await matriculaApi!.getMatricula(TokenUtil.TOKEN).then(
        (value) => value.data,
      );
      data.forEach(
        (el) async {
          await matriculaDao.insertarMatricula(
            MatriculaModelo(
              id: el.id,
              estado: el.estado,
              periodoId: el.periodoId,
              personaId: el.personaId,
            ),
          );
        },
      );
      return data;
    } else {
      return await matriculaDao.listarMatricula();
    }
  }

  Future<RespMatriculaModelo> deleteMatricula(int id) async {
    return await matriculaApi!.deleteMatricula(TokenUtil.TOKEN, id);
  }

  Future<RespMatriculaModelo> updateMatricula(
    int id,
    MatriculaModelo matricula,
  ) async {
    return await matriculaApi!.updateMatricula(TokenUtil.TOKEN, id, matricula);
  }

  Future<RespMatriculaModelo> createMatricula(MatriculaModelo matricula) async {
    return await matriculaApi!.createMatricula(TokenUtil.TOKEN, matricula);
  }
}
