import 'package:servicio_asistencia/models/evento/EventoModelo.dart';
import 'package:floor/floor.dart';

@dao
abstract class EventoDao {
  @Query('SELECT * FROM evento')
  Future<List<EventoModelo>> listarEvento();

  @Query('SELECT * FROM evento WHERE id = :id')
  Stream<EventoModelo?> buscarEventoPorId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertarEvento(EventoModelo evento);

  @Update()
  Future<void> actualizarEvento(EventoModelo evento);

  @delete
  Future<void> eliminarEvento(EventoModelo evento);
}
