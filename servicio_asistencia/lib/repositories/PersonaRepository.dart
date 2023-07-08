import 'package:servicio_asistencia/apis/persona/persona_api.dart';
import 'package:servicio_asistencia/local/db/database.dart';
import 'package:servicio_asistencia/models/persona/PersonaModelo.dart';
import 'package:servicio_asistencia/util/NetworConnection.dart';
import 'package:servicio_asistencia/util/TokenUtil.dart';
import 'package:dio/dio.dart';

class PersonaRepository {
  PersonaApi? personaApi;

  PersonaRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    personaApi = PersonaApi(_dio);
  }

  Future<AppDatabase> conection() async {
    return await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  }

  Future<List<PersonaModelo>> getPersona() async {
    print('llego');
    final database = await conection();
    final personaDao = database.personaDao;
    print('llego');
    if (await isConected()) {
          print('llego2');
      var dats;
      try {
        dats = await personaApi!.getPersona(TokenUtil.TOKEN).then((value){print('sdaad');value.data;} );
      print('dats');
      } catch (e) {
        print(e.toString());
      }
      
      dats.forEach((el) async {
        await personaDao.insertarPersona(PersonaModelo(
          id: el.id,
          dni: el.dni,
          codigo: el.codigo,
          nombre: el.nombre,
          apellidoPaterno: el.apellidoPaterno,
          apellidoMaterno: el.apellidoMaterno,
          telefono: el.telefono,
          genero: el.genero,
          correo: el.correo,
          estado: el.estado,
          escuelaId: el.escuelaId,
        ));
      });
      return dats;
    } else {
      return await personaDao.listarPersona();
    }
  }

  Future<RespPersonaModelo> deletePersona(int id) async {
    return await personaApi!.deletePersona(TokenUtil.TOKEN, id);
  }

  Future<RespPersonaModelo> updatePersona(int id, PersonaModelo persona) async {
    return await personaApi!.updatePersona(TokenUtil.TOKEN, id, persona);
  }

  Future<RespPersonaModelo> createPersona(PersonaModelo persona) async {
    return await personaApi!.createPersona(TokenUtil.TOKEN, persona);
  }
}
