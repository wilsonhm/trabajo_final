import 'package:servicio_asistencia/models/facultad/FacultadModelo.dart';
import 'package:floor/floor.dart';

@dao
abstract class FacultadDao {
  @Query('SELECT * FROM facultad')
  Future<List<FacultadModelo>> listarFacultad();

  @Query('SELECT * FROM facultad WHERE id = :id')
  Stream<FacultadModelo?> buscarFacultadPorId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertarFacultad(FacultadModelo facultad);

  @Update()
  Future<void> actualizarFacultad(FacultadModelo facultad);

  @delete
  Future<void> eliminarFacultad(FacultadModelo facultad);
}
