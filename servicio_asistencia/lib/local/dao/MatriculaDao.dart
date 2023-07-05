import 'package:servicio_asistencia/models/matricula/MatriculaModelo.dart';
import 'package:floor/floor.dart';

@dao
abstract class MatriculaDao {
  @Query('SELECT * FROM matricula')
  Future<List<MatriculaModelo>> listarMatricula();

  @Query('SELECT * FROM matricula WHERE id = :id')
  Stream<MatriculaModelo?> buscarMatriculaPorId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertarMatricula(MatriculaModelo matricula);

  @Update()
  Future<void> actualizarMatricula(MatriculaModelo matricula);

  @delete
  Future<void> eliminarMatricula(MatriculaModelo matricula);
}
