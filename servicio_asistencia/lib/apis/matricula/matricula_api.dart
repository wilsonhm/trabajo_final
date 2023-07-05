import 'package:servicio_asistencia/models/matricula/MatriculaModelo.dart';
import 'package:servicio_asistencia/util/url_api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
part 'matricula_api.g.dart';

@RestApi(baseUrl: UrlApi.urlApix)
abstract class MatriculaApi {
  factory MatriculaApi(Dio dio, {String baseUrl}) = _MatriculaApi;

  static MatriculaApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return MatriculaApi(dio);
  }

  @GET("/api/matricula")
  Future<RespMatriculaModelo> getMatricula(@Header("Authorization") String token);

  @POST("/api/matricula")
  Future<RespMatriculaModelo> createMatricula(
    @Header("Authorization") String token,
    @Body() MatriculaModelo matricula,
  );

  @DELETE("/api/matricula/{id}")
  Future<RespMatriculaModelo> deleteMatricula(
    @Header("Authorization") String token,
    @Path("id") int id,
  );

  @PATCH("/api/matricula/{id}")
  Future<RespMatriculaModelo> updateMatricula(
    @Header("Authorization") String token,
    @Path("id") int id,
    @Body() MatriculaModelo matricula,
  );
}
