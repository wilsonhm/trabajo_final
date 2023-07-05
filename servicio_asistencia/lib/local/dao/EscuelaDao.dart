import 'package:servicio_asistencia/models/escuela/EscuelaModelo.dart';
import 'package:floor/floor.dart';

@dao
abstract class EscuelaDao {
  @Query('SELECT * FROM escuela')
  Future<List<EscuelaModelo>> listarEscuela();

  @Query('SELECT * FROM escuela WHERE id = :id')
  Stream<EscuelaModelo?> buscarEscuelaPorId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertarEscuela(EscuelaModelo escuela);

  @Update()
  Future<void> actualizarEscuela(EscuelaModelo escuela);

  @delete
  Future<void> eliminarEscuela(EscuelaModelo escuela);
}
