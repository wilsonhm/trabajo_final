import 'package:servicio_asistencia/models/escuela/EscuelaModelo.dart';
import 'package:servicio_asistencia/util/url_api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
part 'escuela_api.g.dart';

@RestApi(baseUrl: UrlApi.urlApix)
abstract class EscuelaApi {
  factory EscuelaApi(Dio dio, {String baseUrl}) = _EscuelaApi;

  static EscuelaApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return EscuelaApi(dio);
  }

  @GET("/api/escuela")
  Future<RespEscuelaModelo> getEscuela(@Header("Authorization") String token);

  @POST("/api/escuela")
  Future<RespEscuelaModelo> createEscuela(
    @Header("Authorization") String token,
    @Body() EscuelaModelo escuela,
  );

  @DELETE("/api/escuela/{id}")
  Future<RespEscuelaModelo> deleteEscuela(
    @Header("Authorization") String token,
    @Path("id") int id,
  );

  @PATCH("/api/escuela/{id}")
  Future<RespEscuelaModelo> updateEscuela(
    @Header("Authorization") String token,
    @Path("id") int id,
    @Body() EscuelaModelo escuela,
  );
}
