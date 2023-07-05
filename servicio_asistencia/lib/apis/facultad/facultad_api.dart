import 'package:servicio_asistencia/models/facultad/FacultadModelo.dart';
import 'package:servicio_asistencia/util/url_api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
part 'facultad_api.g.dart';

@RestApi(baseUrl: UrlApi.urlApix)
abstract class FacultadApi {
  factory FacultadApi(Dio dio, {String baseUrl}) = _FacultadApi;

  static FacultadApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return FacultadApi(dio);
  }

  @GET("/api/facultad")
  Future<RespFacultadModelo> getFacultad(@Header("Authorization") String token);

  @POST("/api/facultad")
  Future<RespFacultadModelo> createFacultad(
    @Header("Authorization") String token,
    @Body() FacultadModelo facultad,
  );

  @DELETE("/api/facultad/{id}")
  Future<RespFacultadModelo> deleteFacultad(
    @Header("Authorization") String token,
    @Path("id") int id,
  );

  @PATCH("/api/facultad/{id}")
  Future<RespFacultadModelo> updateFacultad(
    @Header("Authorization") String token,
    @Path("id") int id,
    @Body() FacultadModelo facultad,
  );
}
