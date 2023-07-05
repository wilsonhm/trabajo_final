import 'package:servicio_asistencia/models/asistencia/AsistenciaModelo.dart';
import 'package:floor/floor.dart';

@dao
abstract class AsistenciaDao {
  @Query('SELECT * FROM asistencia')
  Future<List<AsistenciaModelo>> listarAsistencia();

  @Query('SELECT * FROM asistencia WHERE id = :id')
  Stream<AsistenciaModelo?> buscarAsistenciaPorId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertarAsistencia(AsistenciaModelo asistencia);

  @Update()
  Future<void> actualizarAsistencia(AsistenciaModelo asistencia);

  @delete
  Future<void> eliminarAsistencia(AsistenciaModelo asistencia);
}
