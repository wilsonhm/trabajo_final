import 'package:asistencia_app/modelo/UsuarioModelo.dart';
import 'package:asistencia_app/util/UrlApi.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
part 'usuario_api.g.dart';
@RestApi(baseUrl: UrlApi.urlApix)
abstract class UsuarioApi {
  factory UsuarioApi(Dio dio, {String baseUrl}) = _UsuarioApi;
  static UsuarioApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return UsuarioApi(dio);
  }
  @POST("/api/auth/login") //davidmpx@upeu.edu.pe //D123456
  Future<TokenModelo> login(@Body() UsuarioModelo usuario);
}