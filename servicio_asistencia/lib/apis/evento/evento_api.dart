import 'package:servicio_asistencia/models/evento/EventoModelo.dart';
import 'package:servicio_asistencia/util/url_api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
part 'evento_api.g.dart';

@RestApi(baseUrl: UrlApi.urlApix)
abstract class EventoApi {
  factory EventoApi(Dio dio, {String baseUrl}) = _EventoApi;

  static EventoApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return EventoApi(dio);
  }

  @GET("/api/evento")
  Future<RespEventoModelo> getEvento(@Header("Authorization") String token);

  @POST("/api/evento")
  Future<RespEventoModelo> createEvento(
    @Header("Authorization") String token,
    @Body() EventoModelo evento,
  );

  @DELETE("/api/evento/{id}")
  Future<RespEventoModelo> deleteEvento(
    @Header("Authorization") String token,
    @Path("id") int id,
  );

  @PATCH("/api/evento/{id}")
  Future<RespEventoModelo> updateEvento(
    @Header("Authorization") String token,
    @Path("id") int id,
    @Body() EventoModelo evento,
  );
}
