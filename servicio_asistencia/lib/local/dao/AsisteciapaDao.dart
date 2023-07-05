import 'package:servicio_asistencia/models/asisteciapa/AsisteciapaModelo.dart';
import 'package:floor/floor.dart';

@dao
abstract class AsisteciapaDao {
  @Query('SELECT * FROM asisteciapa')
  Future<List<AsisteciapaModelo>> listarAsisteciapa();

  @Query('SELECT * FROM asisteciapa WHERE id = :id')
  Stream<AsisteciapaModelo?> buscarAsisteciapaPorId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertarAsisteciapa(AsisteciapaModelo asisteciapa);

  @Update()
  Future<void> actualizarAsisteciapa(AsisteciapaModelo asisteciapa);

  @delete
  Future<void> eliminarAsisteciapa(AsisteciapaModelo asisteciapa);
}
