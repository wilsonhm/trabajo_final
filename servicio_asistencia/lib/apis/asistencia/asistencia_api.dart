import 'package:servicio_asistencia/models/asistencia/AsistenciaModelo.dart';
import 'package:servicio_asistencia/util/url_api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
part 'asistencia_api.g.dart';

@RestApi(baseUrl: UrlApi.urlApix)
abstract class AsistenciaApi {
  factory AsistenciaApi(Dio dio, {String baseUrl}) = _AsistenciaApi;

  static AsistenciaApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return AsistenciaApi(dio);
  }

  @GET("/api/asistencia")
  Future<RespAsistenciaModelo> getAsistencia(@Header("Authorization") String token);

  @POST("/api/asistencia")
  Future<RespAsistenciaModelo> createAsistencia(
    @Header("Authorization") String token,
    @Body() AsistenciaModelo asistencia,
  );

  @DELETE("/api/asistencia/{id}")
  Future<RespAsistenciaModelo> deleteAsistencia(
    @Header("Authorization") String token,
    @Path("id") int id,
  );

  @PATCH("/api/asistencia/{id}")
  Future<RespAsistenciaModelo> updateAsistencia(
    @Header("Authorization") String token,
    @Path("id") int id,
    @Body() AsistenciaModelo asistencia,
  );
}
