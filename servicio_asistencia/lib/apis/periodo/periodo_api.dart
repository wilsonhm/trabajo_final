import 'package:servicio_asistencia/models/periodo/PeriodoModelo.dart';
import 'package:servicio_asistencia/util/url_api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
part 'periodo_api.g.dart';

@RestApi(baseUrl: UrlApi.urlApix)
abstract class PeriodoApi {
  factory PeriodoApi(Dio dio, {String baseUrl}) = _PeriodoApi;

  static PeriodoApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return PeriodoApi(dio);
  }

  @GET("/api/periodo")
  Future<RespPeriodoModelo> getPeriodo(@Header("Authorization") String token);

  @POST("/api/periodo")
  Future<RespPeriodoModelo> createPeriodo(
    @Header("Authorization") String token,
    @Body() PeriodoModelo periodo,
  );

  @DELETE("/api/periodo/{id}")
  Future<RespPeriodoModelo> deletePeriodo(
    @Header("Authorization") String token,
    @Path("id") int id,
  );

  @PATCH("/api/periodo/{id}")
  Future<RespPeriodoModelo> updatePeriodo(
    @Header("Authorization") String token,
    @Path("id") int id,
    @Body() PeriodoModelo periodo,
  );
}
