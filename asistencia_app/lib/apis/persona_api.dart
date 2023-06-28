import 'package:asistencia_app/modelo/PersonaModelo.dart'; 
import 'package:asistencia_app/util/UrlApi.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'persona_api.g.dart'; 

@RestApi(baseUrl: UrlApi.urlApix)
abstract class PersonaApi {
  factory PersonaApi(Dio dio, {String baseUrl}) = _PersonaApi;

  static PersonaApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return PersonaApi(dio);
  }

  @GET("/api/persona") 
  Future<RespPersonaModelo> getPersona(@Header("Authorization") String token);

  @POST("/api/persona") 
  Future<RespPersonaModelo> createPersona(
      @Header("Authorization") String token, @Body() PersonaModelo persona);

  @DELETE("/api/persona/{id}") 
  Future<RespPersonaModelo> deletePersona(
      @Header("Authorization") String token, @Path("id") int id);

  @PATCH("/api/persona/{id}") 
  Future<RespPersonaModelo> updatePersona(
      @Header("Authorization") String token,
      @Path("id") int id,
      @Body() PersonaModelo persona);
}
