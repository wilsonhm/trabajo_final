import 'package:servicio_asistencia/models/persona/PersonaModelo.dart';
import 'package:floor/floor.dart';

@dao
abstract class PersonaDao {
  @Query('SELECT * FROM persona')
  Future<List<PersonaModelo>> listarPersona();

  @Query('SELECT * FROM persona WHERE id = :id')
  Stream<PersonaModelo?> buscarPersonaPorId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertarPersona(PersonaModelo persona);

  @Update()
  Future<void> actualizarPersona(PersonaModelo persona);

  @delete
  Future<void> eliminarPersona(PersonaModelo persona);
}
