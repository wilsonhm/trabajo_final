import 'package:servicio_asistencia/models/periodo/PeriodoModelo.dart';
import 'package:floor/floor.dart';

@dao
abstract class PeriodoDao {
  @Query('SELECT * FROM periodo')
  Future<List<PeriodoModelo>> listarPeriodo();

  @Query('SELECT * FROM periodo WHERE id = :id')
  Stream<PeriodoModelo?> buscarPeriodoPorId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertarPeriodo(PeriodoModelo periodo);

  @Update()
  Future<void> actualizarPeriodo(PeriodoModelo periodo);

  @delete
  Future<void> eliminarPeriodo(PeriodoModelo periodo);
}
