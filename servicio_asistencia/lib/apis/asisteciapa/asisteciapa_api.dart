import 'package:servicio_asistencia/models/asisteciapa/AsisteciapaModelo.dart';
import 'package:servicio_asistencia/util/url_api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'asisteciapa_api.g.dart';

@RestApi(baseUrl: UrlApi.urlApix) // Actualiza la URL base
abstract class AsisteciapaApi {
  factory AsisteciapaApi(Dio dio, {String baseUrl}) = _AsisteciapaApi; // Actualiza el nombre de la fábrica

  static AsisteciapaApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return AsisteciapaApi(dio);
  }

  @GET("/api/asispa") // Actualiza la ruta GET para obtener asisteciapa
  Future<RespAsisteciapaModelo> getAsisteciapa(@Header("Authorization") String token);

  @POST("/api/asispa") // Actualiza la ruta POST para crear asisteciapa
  Future<RespAsisteciapaModelo> createAsisteciapa(
      @Header("Authorization") String token, @Body() RespAsisteciapaModelo asisteciapa);

  @DELETE("/api/asispa/{id}") // Actualiza la ruta DELETE para eliminar asisteciapa
  Future<RespAsisteciapaModelo> deleteAsisteciapa(
      @Header("Authorization") String token, @Path("id") int id);

  @PATCH("/api/asistencia/{id}")
  Future<RespAsisteciapaModelo> updateAsisteciapa(
    @Header("Authorization") String token,
    @Path("id") int id,
    @Body() RespAsisteciapaModelo asistencia,
  );

}
